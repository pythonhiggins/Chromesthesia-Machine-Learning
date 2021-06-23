# Chromesthesia-Machine-Learning
A simple sound to colour mapping based on the principle of Chromesthesia executed using wekinator and processing

This project is a very simple machine learning model designed to map colours to simple notes, using the principles of Chromesthesia http://www.endolith.com/wordpress/2010/09/15/a-mapping-between-musical-notes-and-colors/
This version is trained on a ukelele using the basic four strings, so A, E, C and G are trained, but it would be easy to train your own output

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
https://processing.org/ (Credit to Daniel Schiffman)





