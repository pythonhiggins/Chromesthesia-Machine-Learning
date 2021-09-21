# Chromesthesia-Machine-Learning
A sound to colour mapping tool based on the principle of Chromesthesia (people who see colour when they hear sound) executed using wekinator and processing.

The project turns your device's screen into a chromosthesia modelling device, using the microphone. For example if the mic hears a C note, the screen reacts with Green.

The system is real time and dynamic, it can deal with a full spectrum of notes, and each note is organically calculed and displayed using the RGB properties of that exact sound

This project is a simple machine learning model designed for a university Sound Communication class http://www.endolith.com/wordpress/2010/09/15/a-mapping-between-musical-notes-and-colors/
This version is trained on a ukelele using the basic four strings, so A, E, C and G are trained, but it would be easy to train your own output using the steps

1. Install Processing on your machine  </br>
   Install oscP5 library
   </br></br>

2. Open the Audio_Input Processing Source Code in Processing</br>
  Hit Run. You should see an equalizer mapping your mic input. Leave it open. 
  </br></br>

3. Install Wekinator</br>
  Run the WekinatorProjectRGB file
Alternately here, you could create your own Wekinator project with 26 inputs, and three outputs (one for each of the RGB elements)
and set the value of each of the three outputs to the respective R, G or B value (divided by 255) 
</br></br>

4. Open the Colour_Project_RGB Source Code in Processing</br>
 Hit run. Now you should have two Processing Windows open
 </br></br>

5. Go back to wekinator, and hit Run on your trained model</br>
  Play some notes and have fun!
</br></br>
**Note**: Flick through the ppt file if you have trouble understanding</br>
**Note 2**: Wekinator sends processing exactly 3 RGB outputs which are simple to use in your other projects. Get creative with them!
</br></br>
Licensing: Much of the Processing, and Wekinator code is taken from their free samples available at: 
http://www.wekinator.org/examples/
https://processing.org/ (Credit to Daniel Schiffman)</br>
Thanks to Rafael Ramirez Melendez & Sergio Giraldo Mendez (UPF)





