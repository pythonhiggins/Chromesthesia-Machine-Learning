import processing.video.*;

import oscP5.*;
import netP5.*;
  
import processing.sound.*;

OscP5 oscP5;
NetAddress dest;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

//MFCCs globals
int MEL_FILT_NUM = 26;
int MFCC_FREC_BAND_NUM = 13;
float[] coef_m = new float[MEL_FILT_NUM + 2];//coeficients vector in mel
float[] coef = new float[MEL_FILT_NUM + 2];//coeficients vector in Hz
int[] f = new int[MEL_FILT_NUM + 2];//coeficients vector in bins
float[][] filterBanksMatrix = new float[bands][MEL_FILT_NUM];
float[] mfsc = new float[MEL_FILT_NUM];

float sampleRate = 44100;
float highFrecBound = 1125*log(1 + (11000/700));//in Mel: M(f) = 1124ln(1+f/700)
float lowFrecBound = 1125*log(1 + (0/700));// in mel
float step = (highFrecBound-lowFrecBound) / (MEL_FILT_NUM + 1);//In mel

//bar chart for MFCCs
int win_width = 512;
int win_heigth = 360;

void setup() {
  size(512, 360);
  background(255);
  colorMode(RGB, 1.0);
  stroke(0.0);  
  
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
  
  //Compute mel filter bank (26 filters) This is done only once
        
  coef_m[0] = lowFrecBound;       
  for (int i = 1; i<MEL_FILT_NUM + 2; i++) {//create coeficients
    coef_m[i] = coef_m[i-1] + step;//fill up the mel coeficients vector incrementing from low to high bound, incrementing by the step (in mel)
    coef[i] = 700 * (exp(coef_m[i] / 1125) - 1);//convert fo frequency
    f[i] = int((bands + 1) * coef[i] / sampleRate);//round frequency to the closest FFT bin
  }
  //create filters
            
  for (int m = 1; m < MEL_FILT_NUM-1; m++) {
    for (int k=0; k<bands; k++) {
      if (k<f[m-1]) {
        filterBanksMatrix[k][m] = 0;
      }else if (f[m-1] <= k && k <= f[m]){
        filterBanksMatrix[k][m] = ((float)k-(float)f[m-1])/((float)f[m]-(float)f[m-1]);
      }else if (f[m] <= k && k<=f[m+1]){
        filterBanksMatrix[k][m] = ((float)f[m+1]-(float)k)/((float)f[m+1]-(float)f[m]);
      }else if (k > f[m+1]){
        filterBanksMatrix[k][m] = 0;
      }
    }
  }
  
  oscP5 = new OscP5(this,9000);
  dest = new NetAddress("127.0.0.1",6448);
}    

void draw() { 
  background(255);
  fft.analyze(spectrum);
  mfcc();
  //print FFT
  for(int i = 0; i < bands; i++){
  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    line( i, height, i, height - spectrum[i]*height*5 );
  }
  //print MFCCs
  
  for(int i = 0; i < MEL_FILT_NUM ; i++){
    int bar_width = win_width/MEL_FILT_NUM;
    int spaceBetweenBars = bar_width/10;
    int x_pos = ((bar_width - spaceBetweenBars)*i)+bar_width/2;
    rect(x_pos, height, bar_width, (height - mfsc[i]*height)/10);
  }
  if(frameCount % 2 == 0) {
    sendOsc();
  } 
}

void mfcc(){
  ///MFCC
  //multiply each filter bank by power spectrum and sume up
  for (int m=0; m<MEL_FILT_NUM; m++) {
    float accum = 0;
    for (int k=0; k<bands; k++) {
      //float magSpecLin = pow(10, (spectrum[k]/20));
      float magSpecLin = spectrum[k];
      //println(magSpecLin);
      //println(" ", filterBanksMatrix[k][m]);
      if(magSpecLin==magSpecLin && filterBanksMatrix[k][m]==filterBanksMatrix[k][m]){//if not NaN
        accum += (filterBanksMatrix[k][m]* magSpecLin)*1000;
      }
    }
    mfsc[m] = accum;
  }
}

void sendOsc() {
  OscMessage msg = new OscMessage("/wek/inputs");
 // msg.add(px);
   for (int i = 0; i < MEL_FILT_NUM ; i++) {
      msg.add(mfsc[i]); 
   }
  oscP5.send(msg, dest);
}
