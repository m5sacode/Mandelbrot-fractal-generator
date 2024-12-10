import controlP5.*;
Textlabel posicionX;
Textlabel posicionY;
Textlabel iteracts;
Textlabel coloracion;
float cx=0, cy=0, zx=0, zy=0, lzx=0, lzy=0;
float scaperad = 4;
int i = 0;
boolean escapa = false;
int iter = 100;
float bottomx, topx, lbottomx, ltopx;
float bottomy = -1.42, topy = 1.42, lbottomy, ltopy;
ControlP5 cp5;
float kcolorr = 8, kcolorg = 2, kcolorb = 0;
int maxiter = 500;
boolean colores = false;
boolean gui = true;
void setup() {
  cp5 = new ControlP5(this);
  fullScreen();
  bottomx = bottomy*width/height ;
  topx = topy*width/height;
  posicionX = cp5.addTextlabel("PosicionX")
    .setText("Posicion en X: "+ bottomx +" , "+ topx)
    .setPosition(10, 10)
    .setColor(255/2)
    .setFont(createFont("Impact", 30))
    ;
  posicionY = cp5.addTextlabel("PosicionY")
    .setText("Posicion en Y: "+ bottomy +" , "+ topy)
    .setPosition(10, 45)
    .setColor(255/2)
    .setFont(createFont("Impact", 30))
    ;
  iteracts = cp5.addTextlabel("iterations")
    .setPosition(10, 80)
    .setFont(createFont("Impact", 30))
    .setText("Iteraciones: "  + iter)
    .setColor(255/2)
    ;
  coloracion = cp5.addTextlabel("coloracion")
    .setPosition(10, 115)
    .setFont(createFont("Impact", 30))
    .setText("Metodo de coloracion: Binario")
    .setColor(255/2)
    ;
}
void draw() {
  background(0, 200, 0);
  if (gui)iteracts.setText("Iteraciones: "  + iter);
  if (!gui)iteracts.setText("");
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
          if (colores)stroke(i*kcolorr, i*kcolorg, i*kcolorb);
          if (!colores)stroke(0);
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
        if (colores)stroke(0);
        if (!colores)stroke(255);
        point(x+(width/2), y+(height/2));
      }
    }
    updatePixels();
  }
  if (gui) {
    strokeWeight(2);
    stroke(0, 0, 255, 150);
    line(10+(width/2), (height/2), (width/2)-10, (height/2));
    line((width/2), 10+(height/2), (width/2), (height/2)-10);
    posicionX.setText("Posicion en X: "+ bottomx +" , "+ topx);
    posicionY.setText("Posicion en Y: "+ bottomy +" , "+ topy);
    if (colores)coloracion.setText("Metodo de coloracion: Iteracion de escape");
    if (!colores)coloracion.setText("Metodo de coloracion: Binario");
  } else {
    posicionX.setText("");
    posicionY.setText("");
    coloracion.setText("");
  }
}
void mousePressed() {
  iter = round(map(height-mouseY, 0, height, 0, maxiter));
}
void keyReleased()
{

  lbottomx = bottomx;
  lbottomy = bottomy;
  ltopx = topx;
  ltopy = topy;
  if (key == 'a')
  {
    bottomx = lbottomx - 0.1*(ltopx-lbottomx);
    topx = ltopx - 0.1*(ltopx-lbottomx);
  }
  if (key == 'd')
  {
    bottomx = lbottomx + 0.1*(ltopx-lbottomx);
    topx = ltopx + 0.1*(ltopx-lbottomx);
  }
  if (key == 'w')
  {
    bottomy = lbottomy - 0.1*(ltopy-lbottomy);
    topy = ltopy - 0.1*(ltopy-lbottomy);
  }
  if (key == 's')
  {
    bottomy = lbottomy + 0.1*(ltopy-lbottomy);
    topy = ltopy + 0.1*(ltopy-lbottomy);
  }
  if (key == 'e')
  {
    bottomy = lbottomy + 0.3*(ltopy-lbottomy);
    topy = ltopy - 0.3*(ltopy-lbottomy);

    bottomx = lbottomx + 0.3*(ltopx-lbottomx);
    topx = ltopx - 0.3*(ltopx-lbottomx);
  }
  if (key == 'q')
  {
    bottomy = lbottomy - 0.3*(ltopy-lbottomy);
    topy = ltopy + 0.3*(ltopy-lbottomy);

    bottomx = lbottomx - 0.3*(ltopx-lbottomx);
    topx = ltopx + 0.3*(ltopx-lbottomx);
  }
  if (key == 'c')
  {
    if (!colores) {
      colores=true;
    } else {
      colores=false;
    }
  }
  if (key == 'x')
  {
    if (!gui) {
      gui=true;
    } else {
      gui=false;
    }
  }
}
