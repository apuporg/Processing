// Button Answer
int rectX, rectY, rectX2, rectY2;      // Position of square button
int rectSize = 40;     // Rect size
boolean buttonOver = false;  // Is mouse over button
boolean buttonPressed;        // Button is activated
color buttonColor;      // default color
color buttonHighlight;  // pressed color


// Images
PImage imgbase;
PImage img;
int hue_number;
boolean hue_on;
  
// status on update need
boolean status;
boolean drawn_status;

// fonts removed for Git
//  PFont font;
//  PFont font2;
//  PFont font12;

void setup() {
  size(1079, 617);
  colorMode(HSB);
  //font   = loadFont("Calibri-35.vlw");  // fonts removed for Git
  //font2  = loadFont("Calibri-20.vlw");
  //font12 = loadFont("Calibri-12.vlw");

  // Images
    imgbase = loadImage("images/twirl_base.jpg");
    img = loadImage("images/twirl.jpg");
    resetImage();
    hue_number = 0;
    hue_on = false;

  // Button Answer
    rectX = 353;
    rectX2 = 443;
    rectY = 583;
    rectY2 = 608;
    buttonHighlight = color(125);
    buttonColor = color(0);
    buttonPressed = false;

    
  // status
    status = true;
    drawn_status = true;
}

void draw() {
  // Track mouse
    update();
  
  // Button  
    // button outlook
    if (buttonOver) {
      fill(buttonHighlight);
    } else {
      fill(buttonColor);
    }
    stroke(0);
    strokeWeight(1);
    rect(rectX, rectY, (rectX2-rectX), (rectY2-rectY),5);
  
    // button text
    if (buttonPressed){
      fill(0);
    } else {
      fill(255);
    }
    textSize(12); //textFont(font12,12); // fonts removed for Git
    text("answer", (rectX+23), (rectY+16)); // button text

    // Update image if needed
    if(drawn_status!=status){
      updateImage(hue_number);
      drawn_status=status;
      
    }
 
    // Painting path
      // execution direction
      if (buttonPressed){
        stroke(#009CB8);
        strokeWeight(15);
        line(868, 440, 686, 440);
        line(686, 440, 686, 125);
        line(686, 125, 950, 125);      
        line(925, 145, 950, 125);  
        line(925, 105, 950, 125);  
        
      // order of paint
      text("1", 104, 119);   
        line(106, 119, 427, 119);      
        line(427, 119, 427, 272);  
        line(106, 272, 427, 272); 
        line(106, 272, 106, 412);
        line(86,  393, 106, 412);
        line(106, 412, 126, 393);
      }
      
    // Description texts
      fill(0);
      textSize(35); // textFont(font,35); // fonts removed for Git
      text("Time series of a Triptych", 100, 550);                 // Title
      textSize(20); //textFont(font2,20); // fonts removed for Git
      text(" - pick colors and analyze execution order", 100, 575); // description
}

// draw basic image
void resetImage(){
    image(imgbase, 0, 0);
    image(img, 540, 0);
}

// Update images according to parameter hue value
void updateImage(int hue_no){

  // Images 
  resetImage();


  loadPixels();
  for(int i = 0; i<pixels.length; i++) {
    float b = brightness(pixels[i]);
    float s = saturation(pixels[i]);
    float h = hue(pixels[i]);

    if(hue_no != 1000){
      if(hue(pixels[i])>(hue_no-15) & hue(pixels[i])<(hue_no+15)){
        pixels[i] = color(h,s,b);
      } else {
        pixels[i] = color(h,0,b);
      }
    } else {
      pixels[i] = color(h,s,b);
    }
  }    
  updatePixels();
}


// Change statuses as button for answer activated/deactivated pressed
void mousePressed() {
  
  // mouse is interacting with result button
  if (buttonOver) {
    if(mousePressed){
      if(buttonPressed){
         buttonPressed = false;
         if(buttonColor==color(0)){
           buttonColor = color(255);
         } else {
           buttonColor = color(0);
         }
      } else {
         buttonPressed = true;
         if(buttonColor==color(0)){
           buttonColor = color(255);
         } else {
           buttonColor = color(0);
         }         
      }
    }

    status =false;
    drawn_status = true;

  } else {  // activating color choice: save pixel color hue
    if(hue_on){
      hue_number=1000;
      hue_on = false;
    } else {
      hue_number = Math.round(hue(get(mouseX, mouseY)));
      hue_on = true;
    }
    status = false;
    drawn_status = true;
  }

}

// Is the mouse focus over the button
boolean overButton(int x1, int x2, int y1, int y2)  {
  if (mouseX >= x1 && mouseX <= x2 && 
      mouseY >= y1 && mouseY <= y2) {
    return true;
  } else {
    return false;
  }
}

// Check if mouse is over the button
void update() {
  if ( overButton(rectX, rectX2, rectY, rectY2) ) {
    buttonOver = true;
  } else {
    buttonOver =  false;
  }
}