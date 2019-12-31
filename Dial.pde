PVector mouse;
Dial dial1, dial2;

void init() {
  displaySong();
  mouse = new PVector(); 
  dial1 = new Dial(0, 10, 10, true);
  dial1.setTitle("Volume");
  dial1.toggleValueDisplay();
  dial2 = new Dial(0, 100, 10, true);
  dial2.setPos(new PVector(600f, dial1.pos.y));
  dial2.setTitle("Channel");
  dial2.toggleValueDisplay();
  button1Pos = new PVector(700, 470); //Creates coordinates for the position and sizes for each PVector
  button1Size = new PVector(150, 40);
  button2Pos = new PVector(900, 470);
  button2Size = new PVector(150, 40);
  button3Pos = new PVector(1100, 470);
  button3Size = new PVector(150, 40);
  button4Pos = new PVector(700, 530);
  button4Size = new PVector(150, 40);
  button5Pos = new PVector(1100, 530);
  button5Size = new PVector(150, 40);
  button6Pos = new PVector(700, 600);
  button6Size = new PVector(150, 40);
  button7Pos = new PVector(1100, 600);
  button7Size = new PVector(150, 40);
  rewindPos = new PVector(725, 375);
  rewindSize = new PVector(120, 60);
  pausePos = new PVector(850, 375);
  pauseSize = new PVector(90, 80);
  playPos = new PVector(950, 375);
  playSize = new PVector(85, 80);
  forwardPos = new PVector(1075, 375);
  forwardSize = new PVector(120, 60);
  replayPos = new PVector(600, 375);
  replaySize = new PVector(110, 60);
  skipPos = new PVector(1200, 375);
  skipSize = new PVector(110, 60);
}

class Dial {
  PVector pos, settingVec;

  float radius = 50, setting, max = 10, min = 0; //setting is the current setting
  float numDivisions;
  boolean active = false, rounded = true, displayTitle = true, displayValue = true, display3D = true;

  color fillCol, activeCol = color(0, 180, 200), inactiveCol = color(0, 0, 200);

  String title = "";

  Dial(float min, float max, float num, boolean rounded) {
    this.min = min;
    this.max = max;
    this.numDivisions = num; 

    pos = new PVector(900, 600);
    settingVec = new PVector();
    this.rounded = rounded;

    fillCol = inactiveCol;
  }

  void setPos(PVector p) {
    pos = p.copy();
  }

  void setTitle(String t) {
    title = t;
  }

  boolean detectDial(PVector mousePos) {
    return (PVector.dist(mousePos, pos) < radius);
  }

  void toggleValueDisplay() {
    displayValue = !displayValue;
  }

  void toggle3D() {
    display3D = !display3D;
  }

  void toggleTitleDisplay() {
    displayTitle = !displayTitle;
  }

  void dialInteraction() {
    //we only update is the dial is being dragged
    if (mousePressed) {
      fillCol = activeCol;
      settingVec  = new PVector();
      settingVec.x = mouse.x - pos.x;
      settingVec.y = (mouse.y  - pos.y);
      settingVec.normalize();
      settingVec.mult(radius);           
      //get the value between left side and the setting
      float tempAngle = PVector.angleBetween(new PVector( -1, 0 ), settingVec);

      tempAngle = (tempAngle/PI);//makes the scale between 0 and 1 

      if (rounded) {
        setting = round(tempAngle * (max-min));
        tempAngle = setting / (max-min);
        settingVec.set(radius*cos(PI*(1f+tempAngle)), radius*sin(PI*(1f+tempAngle))) ;
      } else {
        setting =  round((tempAngle * (max-min))*10)/10f;
      }
    } else {
      fill(0, 0, 200);
    }
  }

  void update(PVector mouse) {
    //check whether the user is interacting with this or not
    active = detectDial(mouse);
    fillCol = inactiveCol;
    if (active) {
      dialInteraction();
    }
    drawDial();
  }

  float getSetting(boolean rounded) {
    if (rounded) {
      return round(setting);
    }

    return setting;
  }

  int getSetting() {
    return (int)setting;
  }

  void drawTitle() {
    textSize(radius /2.9);
    text(title, pos.x, pos.y-radius*(1 + 0.5));
  }

  void drawDial() {
    strokeWeight(4);
    textAlign(CENTER, CENTER);
    textSize(radius/6);
    if (display3D) {
      fill(150);
      ellipse(pos.x, pos.y+radius*0.18, radius*2f, radius*2f);
    }
    fill(fillCol);
    ellipse(pos.x, pos.y, radius*2f, radius*2f);
    /* fill(activeCol, 100);
     noStroke();
     println(settingVec.heading());
     arc(pos.x, pos.y, radius*1.6, radius*1.6,  PI, 2*PI+settingVec.heading()); 
     */
    stroke(0);
    line(pos.x, pos.y, pos.x + settingVec.x, pos.y + settingVec.y);

    float range = max - min;
    int values = 0;
    for (float i = - PI; i <= 0.1; i += PI / numDivisions) {
      // print(values);
      PVector temp = new PVector((radius*(1 + 0.22))*cos(i), (radius*(1 + 0.22))*sin(i));

      int tempVal = (int)(min + range * values /numDivisions  );

      fill(0);
      text(""+(int)(tempVal), temp.x+pos.x, temp.y+pos.y);
      values ++;
    }

    if (displayTitle) {
      drawTitle();
    }
    if (displayValue) {   
      text(setting+"", pos.x, 100);
    }
  }
}
