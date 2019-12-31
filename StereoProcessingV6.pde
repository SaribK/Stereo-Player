/*
Sarib Kashif
April 28, 2018
Stereo Player
Verson 1.6, Uses Marquee Text to make a scrolling motion which displays the song. 
Allows the use of arrow keys for pausing, playing, forwarding and rewinding. 
Changes speaker color when song is played. Has a 'skip song' button and 'restart song' button.
This program plays the selected music from a list of songs, in accordance to the button that is selected by the user.
It uses a marquee text to display the song that has been selected at the top and also uses a volume function
to allow the user to adjust the volume. 

Critical Requirements (__/11)
***On time
*Comments and header
*Multiple buttons 
*Multiple sound files are loaded
*Use of Minim or Processing Sound
*Uses the Dial provided
*Use of the volume control functionality 
*UI diagram included
*Buttons switch between sounds properly (logical for your intended device emulation)

Optional Requirements ( ___/4)
Array of sound sources
Many sound files (5+)
Pause functionality
Rewind 
Fast forward
*/

import ddf.minim.*; //Calling the minim library
//Song List and Names
//1 Marshmello - Alone
//2 Alan Walker - Faded
//3 Alan Walker - Spectre
//4 Disco Fever - FN
//5 Disfigure - Blank
//6 Electro-Light - Symbolism
//7 Tobu - Hope
Minim minim; 
float songSelection = 0; //Global Variables
float w = 700;
float h = 275;
float SCC = 0; 
float r2 = 0, g2 = 0, b2 = 0;
float validation = 0;
float col = 0;
float bg = 100;
int i;

PVector button1Pos, button1Size; //creates PVectors for the buttons positions and sizes
PVector button2Pos, button2Size;
PVector button3Pos, button3Size;
PVector button4Pos, button4Size;
PVector button5Pos, button5Size;
PVector button6Pos, button6Size;
PVector button7Pos, button7Size;
PVector rewindPos, rewindSize;  //creates PVectors for command buttons
PVector pausePos, pauseSize; 
PVector playPos, playSize; 
PVector forwardPos, forwardSize; 
PVector replayPos, replaySize;
PVector skipPos, skipSize; 

MarqueeText txt;//<==Declare the variable

VolumeControl volumeControl;

AudioPlayer [] files; //Creates an array of sound files

void setup() {
  size(1800, 800); 
  rectMode(CENTER); 
  textSize(20); 
  init();
  minim = new Minim(this); //Creating a new minim profile
  files = new AudioPlayer[7]; //Creates an array of 7 slots
  for (i = 0; i < files.length; i++) { //For loop runs as long as i is less than the array length
    files[i] = minim.loadFile((i+1) + ".mp3");  //Stores the songs numbered from 1-7
  }
  i=0; //Sets i to 0, in other words, song 1
  volumeControl = new VolumeControl(files, dial1);
}

void draw() {
  drawStereo(); //makes stereo
  volumeControl.update();
  mouse = new PVector(mouseX, mouseY); //Makes a PVector for the mouse position
  dial1.update(mouse);
  noFill();
  txt.update();
  buttonFunction(); //Calls on the button function to check button detection and play the right songs
}

void drawStereo() {
  background(100); 
  strokeWeight(8); //Makes thick outlines
  fill(225); 
  rect(900, 450, 800, 500); //creates main bodies of the stereo
  fill(200); 
  rect(300, 400, 300, 600); 
  rect(1500, 400, 300, 600); 
  strokeWeight(1);

  if (SCC == 0) { //If Speaker Color Change is 0 (If no song is playing)
    fill(#2675A5); 
    ellipse(300, 600, 180, 180); //Left side, bottom speaker
    fill(255); 
    ellipse(300, 600, 140, 140);
    fill(r2, g2, b2); 
    ellipse(300, 600, 110, 110); 

    fill(#2675A5);
    ellipse(1500, 600, 180, 180); //Right side, bottom speaker
    fill(255);
    ellipse(1500, 600, 140, 140);
    fill(r2, g2, b2);
    ellipse(1500, 600, 110, 110); 

    fill(#2675A5);
    ellipse(300, 400, 150, 150); //Left side, middle speaker
    fill(255);
    ellipse(300, 400, 120, 120);
    fill(r2, g2, b2);
    ellipse(300, 400, 100, 100); 

    fill(#2675A5);
    ellipse(1500, 400, 150, 150); //Right side, middle speaker
    fill(255);
    ellipse(1500, 400, 120, 120);
    fill(r2, g2, b2);
    ellipse(1500, 400, 100, 100);

    fill(#2675A5);
    ellipse(1500, 225, 120, 120); //Right side, top speaker
    fill(255);
    ellipse(1500, 225,80,80); 
    fill(r2, g2, b2);
    ellipse(1500, 225, 60, 60); 

    fill(#2675A5);
    ellipse(300, 225, 120, 120); //Left side, top speaker
    fill(255);
    ellipse(300, 225,80,80); 
    fill(r2, g2, b2);
    ellipse(300, 225, 60, 60); 
  } else if (SCC == 1) { //duplicate of previous if statement except variables r2,g2,b2 are changed
    fill(#2675A5);
    ellipse(300, 600, 180, 180); 
    fill(255);
    ellipse(300, 600, 140, 140); 
    fill(r2, g2, b2);
    ellipse(300, 600, 110, 110); 

    fill(#2675A5);
    ellipse(1500, 600, 180, 180); 
    fill(255);
    ellipse(1500, 600, 140, 140); 
    fill(r2, g2, b2);
    ellipse(1500, 600, 110, 110); 

    fill(#2675A5);
    ellipse(300, 400, 150, 150);
    fill(255);
    ellipse(300, 400, 120, 120); 
    fill(r2, g2, b2);
    ellipse(300, 400, 100, 100); 

    fill(#2675A5);
    ellipse(1500, 400, 150, 150);
    fill(255);
    ellipse(1500, 400, 120, 120); 
    fill(r2, g2, b2);
    ellipse(1500, 400, 100, 100); 

    fill(#2675A5);
    ellipse(1500, 225, 120, 120); 
    fill(255);
    ellipse(1500, 225,80,80); 
    fill(r2, g2, b2);
    ellipse(1500, 225, 60, 60);

    fill(#2675A5);
    ellipse(300, 225, 120, 120); 
    fill(255);
    ellipse(300, 225,80,80); 
    fill(r2, g2, b2);
    ellipse(300, 225, 60, 60); 

    if (col == 0) { //This is a loop for changing the speaker color one by one from red to green to blue
      r2+=5; //Adds 5 to the red component over and over making it brighter each time
      if (r2>250) { //When it gets too high, red is set to 0 and the green component starts changing
        r2 = 0;
        col = 1;
      }
    } else if (col == 1) {
      g2+=5;
      if (g2>250) { //When green gets too high, blue starts changing and green is set to 0
        g2 = 0;
        col = 2;
      }
    } else if (col == 2) {
      b2+=5;
      if (b2>255) {
        col = 0;
        b2 = 0;
      }
    }
  }
  strokeWeight(5);

  fill(255);
  rect(rewindPos.x, rewindPos.y, rewindSize.x, rewindSize.y); //Surrounding rectangle for command buttons
  rect(pausePos.x, pausePos.y, pauseSize.x, pauseSize.y); 
  rect(playPos.x, playPos.y, playSize.x, playSize.y); 
  rect(forwardPos.x, forwardPos.y, forwardSize.x, forwardSize.y); 
  rect(600, 375, 110, 60); //Surrounding rectangle for replay button
  rect(1200, 375, 110, 60); //Surrounding rectangle for skip song
  noFill();
  fill(0);
  rect(900, 275, 600, 80); //Display in the main rectangle
  strokeWeight(1);
  fill(0);
  triangle(675, 375, 725, 355, 725, 395); //Rewind button part 1
  triangle(725, 375, 775, 355, 775, 395); //Rewind button part 2
  rect(835, 375, 25, 58); //Pause button left part
  rect(866, 375, 25, 58); //Pause button right part
  triangle(975, 375, 927, 350, 927, 400); //Play button
  triangle(1025, 395, 1025, 355, 1075, 375); //Forward button part 1
  triangle(1075, 395, 1075, 355, 1125, 375); //Forward button part 2
  triangle(630, 395, 630, 355, 580, 375); //Replay Button
  rect(575, 375, 10, 40); 
  triangle(1170, 395, 1170, 355, 1220, 375); //Skip Button
  rect(1225, 375, 10, 40); 
  // rect(700, 275, 200,80);
  // rect(1100, 275, 200,80);

  fill(0);
  rect(180, 400, 30, 600); //Left rectangle black stripe design
  rect(420, 400, 30, 600);
  rect(1620, 400, 30, 600); //Right rectangle black stripe design
  rect(1380, 400, 30, 600);
  //text("X: "+ mouseX+ "Y: " + mouseY, mouseX-10, mouseY-10); //Prints coordinates
  noFill();

  //Sound Buttons
  strokeWeight(4);
  textSize(30);
  rect(button1Pos.x, button1Pos.y, button1Size.x, button1Size.y); //Button 1 outer body
  text("1", 700, 470); //Button 1 Label
  rect(700, 470, 130, 40); //Button 1 inner body
  rect(button2Pos.x, button2Pos.y, button2Size.x, button2Size.y); //Button 2 outer body
  text("2", 900, 470); //Button 2 Label
  rect(900, 470, 130, 40); //Button 2 inner body
  rect(button3Pos.x, button3Pos.y, button3Size.x, button3Size.y); //Button 3 outer body
  text("3", 1100, 470); //Button 3 Label
  rect(1100, 470, 130, 40); //Button 3 inner body
  rect(button4Pos.x, button4Pos.y, button4Size.x, button4Size.y); //Button 4 outer body
  text("4", 700, 530); //Button 4 Label
  rect(700, 530, 130, 40); //Button 4 inner body
  rect(button5Pos.x, button5Pos.y, button5Size.x, button5Size.y); //Button 5 outer body
  text("5", 1100, 530); //Button 5 Label
  rect(1100, 530, 130, 40); //Button 5 inner body
  rect(button6Pos.x, button6Pos.y, button6Size.x, button6Size.y); //Button 6 outer body
  text("6", 700, 600); //Button 6 Label
  rect(700, 600, 130, 40); //Button 6 inner body
  rect(button7Pos.x, button7Pos.y, button7Size.x, button7Size.y); //Button 7 outer body
  text("7", 1100, 600); //Button 7 Label
  rect(1100, 600, 130, 40); //Button 7 inner body
  textSize(1);
}


void keyPressed(){ //Void that is called when a key is pressed
 if(validation == 1){ //If a song has been picked 
  if(keyCode == RIGHT){ //if the right key is pressed
    files[i].skip(5000); //forward ahead 5 seconds
    delay(1000); //delay 1 second
}
else if(keyCode == LEFT) {//if the left key is pressed
 files[i].skip(-5000); //rewind 5 seconds
 delay(1000);
}
else if(keyCode == DOWN){ //if down key is pressed
 files[i].pause(); //pause song
    SCC = 0; 
    r2=0;
    g2=0;
    b2=0;
}
else if(keyCode == UP){ //if up key is pressed
files[i].play(); //play the song
SCC=1;
 }
 }
}
void displaySong(){ //Void for displaying the song name
    if (songSelection == 0) { //If the song selection is set to 0
     txt = new MarqueeText("No Song Selected", 4, 40);//<==call the constructor
     txt.setColor(color(255)); //Make the color white
  } else if (songSelection == 1) { //if the song selection is set to 1
     txt = new MarqueeText("Alone - Marshmello", 4, 40); //call the constructor and display song name
     txt.setColor(color(255)); //set color to white
  } else if (songSelection == 2) {
     txt = new MarqueeText("Faded - Alan Walker", 4, 40);
     txt.setColor(color(255)); //Repeated process until line 302
  } else if (songSelection == 3) {
     txt = new MarqueeText("Spectre - Alan Walker", 4, 40);
     txt.setColor(color(255));
  } else if (songSelection == 4) {
     txt = new MarqueeText("Disco Fever - FN", 4, 40);
     txt.setColor(color(255));
  } else if (songSelection == 5) {
     txt = new MarqueeText("Blank - Disfigure", 4, 40);
     txt.setColor(color(255));
  } else if (songSelection == 6) {
     txt = new MarqueeText("Symbolism - ElectroLight", 4, 40);
     txt.setColor(color(255));
  } else if (songSelection == 7) {
     txt = new MarqueeText("Hope - Tobu", 4, 40);
     txt.setColor(color(255));
  }
}

void buttonFunction() { //Button detection function
  if (abs(mouse.x - button1Pos.x) < button1Size.x/2 && abs(mouse.y - button1Pos.y) < button1Size.y/2) { //if statement to determine if the mouse is on the rectangle
    if (mousePressed) { //if the mouse is pressed 
      stopSong(); //call the stop song function
      songSelection = 1; //Make song selection 0 telling program that the song is Marshmello - Alone
      validation = 1; //Tell the program a song has been selected
      SCC=1; 
      i=0; //Sets i to 0 because thats the location for Marshmello - Alone
      displaySong(); //Display the song
      button1(); //Call on the button 1 function
    }
  } else if (abs(mouse.x - button2Pos.x) < button2Size.x/2 && abs(mouse.y - button2Pos.y) < button2Size.y/2) { 
    if (mousePressed) {
      stopSong(); //Repeated process as previous if statement
      songSelection = 2;
      validation = 1;
      displaySong();
      SCC=1;
      i=1;
      button2();
    }
  } else if (abs(mouse.x - button3Pos.x) < button3Size.x/2 && abs(mouse.y - button3Pos.y) < button3Size.y/2) { 
    if (mousePressed) {
      stopSong(); //Repeated process as previous if statement
      songSelection = 3;
      SCC=1;
      validation = 1;
      displaySong();
      i=2;
      button3();
    }
  } else if (abs(mouse.x - button4Pos.x) < button4Size.x/2 && abs(mouse.y - button4Pos.y) < button4Size.y/2) { 
    if (mousePressed) {
      stopSong(); //Repeated process as previous if statement
      songSelection = 4;
      SCC=1;
      validation = 1;
      displaySong();
      i=3;
      button4();
    }
  } else if (abs(mouse.x - button5Pos.x) < button5Size.x/2 && abs(mouse.y - button5Pos.y) < button5Size.y/2) { 
    if (mousePressed) {
      stopSong(); //Repeated process as previous if statement
      songSelection = 5;
      displaySong();
      SCC=1;
      i=4;
      validation = 1;
      button5();
    }
  } else if (abs(mouse.x - button6Pos.x) < button6Size.x/2 && abs(mouse.y - button6Pos.y) < button6Size.y/2) { 
    if (mousePressed) {
      stopSong(); //Repeated process as previous if statement
      songSelection = 6;
      displaySong();
      SCC=1;
      i=5;
      validation = 1;
      button6();
    }
  } else if (abs(mouse.x - button7Pos.x) < button7Size.x/2 && abs(mouse.y - button7Pos.y) < button7Size.y/2) { 
    if (mousePressed) {
      stopSong(); //Repeated process as previous if statement
      songSelection = 7;
      displaySong();
      i=6;
      validation = 1;
      button7();
    }
  } else if (abs(mouse.x - rewindPos.x) < rewindSize.x/2 && abs(mouse.y - rewindPos.y) < rewindSize.y/2) { //if the user is hovering over the button, call the function
    rewind();
  } else if (abs(mouse.x - pausePos.x) < pauseSize.x/2 && abs(mouse.y - pausePos.y) < pauseSize.y/2) { 
    pause();
  } else if (abs(mouse.x - playPos.x) < playSize.x/2 && abs(mouse.y - playPos.y) < playSize.y/2) { 
    play();
  } else if (abs(mouse.x - forwardPos.x) < forwardSize.x/2 && abs(mouse.y - forwardPos.y) < forwardSize.y/2) { 
    forward();
  } else if (abs(mouse.x - replayPos.x) < replaySize.x/2 && abs(mouse.y - replayPos.y) < replaySize.y/2) { 
    replay();
  } else if (abs(mouse.x - skipPos.x) < skipSize.x/2 && abs(mouse.y - skipPos.y) < skipSize.y/2) { 
    skip();
  }
}

void rewind() { //Rewind function
  fill(#D0D1F0); //Fill the rectangular button with a darker shade
  rect(rewindPos.x, rewindPos.y, rewindSize.x, rewindSize.y);
  strokeWeight(1);
  fill(0);
  triangle(675, 375, 725, 355, 725, 395); //Rewind button part 1
  triangle(725, 375, 775, 355, 775, 395); //Rewind button part 2
  if (mousePressed && validation == 1) { //If validation (a song has been picked), skip 5 seconds back
    files[i].skip(-5000);
    strokeWeight(6); //make the button thicker
    fill(#ACAFF7); //Fill with an even darker shade
    rect(rewindPos.x, rewindPos.y, rewindSize.x, rewindSize.y);
    strokeWeight(1);
    fill(0);
    triangle(675, 375, 725, 355, 725, 395); //Rewind button part 1
    triangle(725, 375, 775, 355, 775, 395); //Rewind button part 2
  }
}

void pause() {
  fill(#D0D1F0);
  rect(pausePos.x, pausePos.y, pauseSize.x, pauseSize.y);
  strokeWeight(1);
  fill(0);
  rect(835, 375, 25, 58); //Pause button left part
  rect(866, 375, 25, 58); //Pause button right part
  if (mousePressed && validation == 1) {
    files[i].pause(); //Pauses the song that is currently playing
    strokeWeight(6);
    fill(#ACAFF7);
    rect(pausePos.x, pausePos.y, pauseSize.x, pauseSize.y);
    strokeWeight(1);
    fill(0);
    rect(835, 375, 25, 58); //Pause button left part
    rect(866, 375, 25, 58); //Pause button right part
    SCC = 0; //Makes the inner body of speakers into black. 
    r2=0;
    g2=0;
    b2=0;
  }
}

void play() {
  fill(#D0D1F0);
  rect(playPos.x, playPos.y, playSize.x, playSize.y);
  strokeWeight(1);
  fill(0);
  triangle(975, 375, 927, 350, 927, 400); //Play button
  if (mousePressed && validation == 1) {
    files[i].play(); //Play the current song
    strokeWeight(6);
    fill(#ACAFF7);
    rect(playPos.x, playPos.y, playSize.x, playSize.y);
    strokeWeight(1);
    fill(0);
    triangle(975, 375, 927, 350, 927, 400); //Play button
    SCC=1; //Start changing speaker colors
  }
}

void forward() {
  fill(#D0D1F0);
  rect(forwardPos.x, forwardPos.y, forwardSize.x, forwardSize.y);
  strokeWeight(1);
  fill(0);
  triangle(1025, 395, 1025, 355, 1075, 375); //Forward button part 1
  triangle(1075, 395, 1075, 355, 1125, 375); //Forward button part 2
  if (mousePressed && validation == 1) {
    files[i].skip(5000); //Skips the current song 5 seconds ahead
    strokeWeight(6);
    fill(#ACAFF7);
    rect(forwardPos.x, forwardPos.y, forwardSize.x, forwardSize.y);
    strokeWeight(1);
    fill(0);
    triangle(1025, 395, 1025, 355, 1075, 375); //Forward button part 1
    triangle(1075, 395, 1075, 355, 1125, 375); //Forward button part 2
  }
}
void replay() {
  fill(#D0D1F0);
  rect(replayPos.x, replayPos.y, replaySize.x, replaySize.y);
  strokeWeight(1);
  fill(0);
  triangle(630, 395, 630, 355, 580, 375); //Replay Button Part 1
  rect(575, 375, 10, 40); //Replay button Part 2
  if (mousePressed && validation == 1) {
    files[i].rewind(); //Start the song from the beginning 
    strokeWeight(6);
    fill(#ACAFF7);
    rect(replayPos.x, replayPos.y, replaySize.x, replaySize.y);
    strokeWeight(1);
    fill(0);
    triangle(630, 395, 630, 355, 580, 375); //Replay Button Part 1
    rect(575, 375, 10, 40); //Replay button Part 2
  }
}
void skip() {
  fill(#D0D1F0);
  rect(skipPos.x, skipPos.y, skipSize.x, skipSize.y);
  strokeWeight(1);
  fill(0);
  triangle(1170, 395, 1170, 355, 1220, 375); //Skip Button Part 1
  rect(1225, 375, 10, 40); //Skip button Part 2
  if (mousePressed && validation == 1) {
    stopSong(); //Stop the song and restart it, but dont play it
    if (i<6) { //If the song that is currently selected is the second last song (6)
      i=i+1; //Change the song to the one right after previous
      files[i].loop(1000); //Loop and play the song
      delay(1000); //Add a 1 second delay 
    } else { //If i is not less than 6 
      i=0; //play the first song
      files[i].loop(1000);
      delay(1000);
    }
    if (i == 0) { //Sets song selection to a certain number in accordance to what song is currently playing
      songSelection = 1;
    } else if (i == 1) {
      songSelection = 2;
    } else if (i == 2) {
      songSelection = 3;
    } else if (i == 3) {
      songSelection = 4;
    } else if (i == 4) {
      songSelection = 5;
    } else if (i == 5) {
      songSelection = 6;
    } else if (i == 6) {
      songSelection = 7;
    }
    strokeWeight(6);
    fill(#ACAFF7);
    rect(skipPos.x, skipPos.y, skipSize.x, skipSize.y);
    strokeWeight(1);
    fill(0);
    triangle(1170, 395, 1170, 355, 1220, 375); //Skip Button Part 1
    rect(1225, 375, 10, 40); //Skip button Part 2
  }
}

void button1() { //All the button functions, when called, loop the song that it is currently on and adds a delay
  files[i].loop(10000);
  delay(1000);
}
void button2() {
  files[i].loop(10000);
  delay(1000);
}
void button3() {
  files[i].loop(10000);
  delay(1000);
}
void button4() {
  files[i].loop(10000); //Sound was not loud enough so an amplification was added to make it louder, the first number (1) is the rate/speed of the song and the second number (5) is the amplification
  delay(1000);
}
void button5() {
  files[i].loop(10000);
  delay(1000);
}
void button6() {
  files[i].loop(10000);
  delay(1000);
}
void button7() {
  files[i].loop(10000);
  delay(1000);
}
public void stopSong() { 
  files[i].pause(); //Pauses the song that is playing when function is called and
  files[i].rewind(); //Starts it from the beginning
}//end
