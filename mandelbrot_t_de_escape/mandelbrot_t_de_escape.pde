import controlP5.*;
Textlabel posicionX;
Textlabel posicionY;
float cx=0, cy=0, zx=0, zy=0, lzx=0, lzy=0;
float tcolormult = 10, mcolormult = 5, acolormult = 1;
float scaperad = 4;
int i = 0;
boolean escapa = false;
int iter = 100;
float bottomx = -2, topx = 2, lbottomx, ltopx;
float bottomy = -2, topy = 2, lbottomy, ltopy;
ControlP5 cp5;
void setup() {
  cp5 = new ControlP5(this);
  size(600, 600);
  posicionX = cp5.addTextlabel("PosicionX")
    .setText("Posicion en X: "+ bottomx +" , "+ topx)
    .setPosition(10, 10)
    .setFont(createFont("Impact", 10))
    ;
  posicionY = cp5.addTextlabel("PosicionY")
    .setText("Posicion en Y: "+ bottomy +" , "+ topy)
    .setPosition(10, 20)
    .setFont(createFont("Impact", 10))
    ;
}
void draw() {
  background(0, 200, 0);
  print("loading....");
  drawfractal();
  println("finished!!");
  println();
  println();
  println();
  println();
  delay(1000);
}
void drawfractal() {
  strokeWeight(1.5);
  for (int y=-(height/2); y<(height/2); y++) {
    for (int x=-(width/2); x<(width/2); x++) {
      //println(x+","+y);
      cx = map(x, -(width/2), (width/2), bottomx, topx);
      cy = map(y, -(height/2), (height/2), bottomy, topy);
      zx = 0;
      zy = 0;
      lzx = 0;
      lzy = 0;
      //z empieza siendo 0
      escapa = false;
      i = 0;
      while (i<iter) {
        zx = (lzx*lzx) - (lzy*lzy) + cx;
        zy = (2*lzx*lzy) + cy;
        //z = z^2 + c
        if ((zx*zx) + (zy*zy)>=scaperad) {
          //println("sí");
          stroke((zx*zx) + (zy*zy)*mcolormult , acolormult*(map(atan(zy/zx), -PI/2, PI/2, 0, 255)) , i*tcolormult);
          point(x+(width/2), y+(height/2));
          escapa = true;
          break;
        }
        lzx = zx;
        lzy = zy;
        i++;
      }
      if (!escapa) {
        //println("no");
        stroke(0);
        point(x+(width/2), y+(height/2));
      }
    }
    updatePixels();
  }
}
void keyReleased()
{

  lbottomx = bottomx;
  lbottomy = bottomy;
  ltopx = topx;
  ltopy = topy;
  if (key == 'a')
  {
    bottomx = lbottomx - 0.5*(ltopx-lbottomx);
    topx = ltopx - 0.5*(ltopx-lbottomx);
  }
  if (key == 'd')
  {
    bottomx = lbottomx + 0.5*(ltopx-lbottomx);
    topx = ltopx + 0.5*(ltopx-lbottomx);
  }
  if (key == 'w')
  {
    bottomy = lbottomy - 0.5*(ltopy-lbottomy);
    topy = ltopy - 0.5*(ltopy-lbottomy);
  }
  if (key == 's')
  {
    bottomy = lbottomy + 0.5*(ltopy-lbottomy);
    topy = ltopy + 0.5*(ltopy-lbottomy);
  }
  if (key == 'e')
  {
    bottomy = lbottomy + 0.2*(ltopy-lbottomy);
    topy = ltopy - 0.2*(ltopy-lbottomy);
    
    bottomx = lbottomx + 0.2*(ltopx-lbottomx);
    topx = ltopx - 0.2*(ltopx-lbottomx);
  }
  if (key == 'q')
  {
    bottomy = lbottomy - 0.2*(ltopy-lbottomy);
    topy = ltopy + 0.2*(ltopy-lbottomy);
    
    bottomx = lbottomx - 0.2*(ltopx-lbottomx);
    topx = ltopx + 0.2*(ltopx-lbottomx);
  }
  posicionX.setText("Posicion en X: "+ bottomx +" , "+ topx);
  posicionY.setText("Posicion en Y: "+ bottomy +" , "+ topy);
}
