int racket1 = 400,racket2 = 400;
int ballx = 500 , bally = 400;
int balldx = 6, balldy = 5;
int scene = -1;
int player1point = 0,player2point = 0;
boolean startfrag1 = true,startfrag2 = false;
boolean issingle = false, ismulti = false;
float gamma = 0.9, alpha = 0.1;
float[][] Q = new float[41][3];
float epsilon = 0.2;


void setup(){
  size(1000, 800);
  startQ();
  processing_AI_learning();
}

void draw(){
  background(255);
  
  if(scene == 1){
    ismulti = true;
    racket1movement();
    strokeWeight(10);
    line(30,racket1-50,30,racket1+50);
    
    racket2movement();
    line(970,racket2-50,970,racket2+50);
    
    textSize(100);
    text(player1point,250,100);
    text(player2point,750,100);
  
  ballmovement();
  
  fill(0);
  ellipse(ballx,bally,20,20);
  
  checkwinner();
  }else if(scene == 2){
    player1win();
  }else if(scene == 3){
    player2win();
  }else if(scene == -1){
    titlescene();
  }else if(scene == 0){
    selectscene();
  }else if(scene == 4){
    issingle =  true;
    singleplayAI();

    racket1movement();

    strokeWeight(10);
    line(30,racket1-50,30,racket1+50);

    line(970,racket2-50,970,racket2+50);

    textSize(100);
    text(player1point,250,100);
    text(player2point,750,100);
  
    ballmovement();
    
    fill(0);
    ellipse(ballx,bally,20,20);
    
    checkwinner();
  }else if(scene == 5){
    startready();
  }
}

void racket2movement(){
  racket2 = mouseY;
  if(racket2<=50){
    racket2 = 50;
  }else if(racket2 >= 750){
    racket2 = 750;
  }
}

void racket1movement(){
  if(keyPressed){
    if(key == 'w'){
      racket1 -= 20;
    }else if(key == 's'){
      racket1 += 20;
    }
  }
  
  if(racket1<=50){
    racket1 = 50;
  }else if(racket1 >= 750){
    racket1 = 750;
  }
}

void ballmovement(){
  ballx = ballx + balldx;
  bally = bally + balldy;
  
  if(ballx>=30+balldx&&ballx<=30){
    if(bally >= racket1-70&&bally <= racket1+70){
      balldx *= -1;
      balldx += random(0,2);
      balldy += random(-8,8);
    }
  }
  
  if(ballx>=970&&ballx<=970+balldx){
    if(bally >= racket2-70&&bally <= racket2+70){
      balldx += random(0,2);
      balldx *= -1;
      balldy += random(-8,8);
    }
  }
  
  if(bally <= 10){
    balldy *= -1;
  }else if(bally >= 790){
    balldy *= -1;
  }
  
}

void checkwinner(){
  if(ballx <= 0){
    player2point++;
    startfrag1 = true;
    ballx=width/2;bally=height/2;
    if(player2point>=10){
      scene = 3;
    }else{
      scene = 5;
    }
  }
  if(ballx >= 1000){
    player1point++;
    startfrag2 = true;
    ballx=width/2;bally=height/2;
    if(player1point>=10){
      scene = 2;
    }else{
      scene = 5;
    }
  }
}

void player1win(){
  background(255);
  textSize(100);
  fill(0);
  if(issingle){
    text("You Win!!!",width/2,height/2);
  }else if(ismulti){
    text("player1 win!!!",width/2,height/2);
  }
  strokeWeight(5);
  fill(255);
  rect(400,500,200,60);
  if(mouseX<=600&&mouseX>=400&&mouseY<=560&&mouseY>=500){
    textSize(40);
    stroke(10);
    fill(0);
    text("Click",width/2,540);
    if(mousePressed){
      scene = -1;
    }
  }else{
     textSize(30);
     stroke(10);
     fill(0);
     text("Return",width/2,540);
  }
}

void player2win(){
  background(255);
  textSize(100);
  fill(0);
  if(issingle){
    text("You Lose...",width/2,height/2);
  }else if(ismulti){
    text("player2 win!!!",width/2,height/2);
  }
  strokeWeight(5);
  fill(255);
  rect(400,500,200,60);
  if(mouseX<=600&&mouseX>=400&&mouseY<=560&&mouseY>=500){
    textSize(40);
    stroke(10);
    fill(0);
    text("Click",width/2,540);
    if(mousePressed){
      scene = -1;
    }
  }else{
     textSize(30);
     stroke(10);
     fill(0);
     text("Return",width/2,540);
  }
}

void titlescene(){
  player1point = 0;
  player2point = 0;
  balldx = 6;
  balldy = 5;
  startfrag1 = true;
  startfrag2 = false;
  issingle = false;
  ismulti = false;
  background(255);
  strokeWeight(5);
  fill(255);
  rect(400,500,200,60);
  
  textSize(50);
  stroke(20);
  fill(0);
  textAlign(CENTER);
  text("Pong Game",width/2,height/2);
  
  if(mouseX<=600&&mouseX>=400&&mouseY<=560&&mouseY>=500){
    textSize(40);
    stroke(10);
    text("Click",width/2,540);
    if(mousePressed){
      scene = 0;
    }
  }else{
     textSize(30);
     stroke(10);
     text("Game Start",width/2,540);
  }
}

void selectscene(){
  background(255);
  textSize(50);
  stroke(20);
  fill(0);
  textAlign(CENTER);
  text("Select Game Mode",width/2,300);
  
  fill(255);
  if(mouseX<=400&&mouseX>=200&&mouseY<=560&&mouseY>=500){
    fill(255,0,0);
    if(mousePressed){
      issingle = true;
      ballx = 500;
      bally = 400;
      scene = 4; // single play
    }
  }
  strokeWeight(5);
  rect(200,500,200,60);
  
  fill(255);
  if(mouseX<=800&&mouseX>=600&&mouseY<=560&&mouseY>=500){
    fill(255,0,0);
    if(mousePressed){
      ismulti = true;
      scene = 5; //multi play
    }
  }
  strokeWeight(5);
  rect(600,500,200,60);
  
  fill(0);
  textSize(40);
  text("Single",300,540);
  
  text("Multi",700,540);
  
}

void startready() {
  strokeWeight(10);
  racket1 = 400;
  racket2 = 400;
  line(30,racket1-50,30,racket1+50);  
  line(970,racket2-50,970,racket2+50);
  
  textSize(30);
  text("player1",100,100);
  text("player2",900,100);
  textSize(100);
  text(player1point,250,100);
  text(player2point,750,100);
    
  fill(0);
  ellipse(ballx,bally,20,20);
    
  if(ismulti){
    if(keyPressed){
      startfrag1 = false;
    }
    if(mousePressed){
      startfrag2 = false;
    }
    
    if(!startfrag1 && !startfrag2){
      if(balldx >= 12){
        balldx -= random(2,4);
      }else if(balldx <= -12){
        balldx += random(2,4);
      }
      if(balldy >= 15){
        balldy -= random(7,15);
      }else if(balldy<=-15){
        balldy += random(7,15);
      }
      balldx *= -1;
      scene = 1;
    }
  }else if(issingle){
    if(keyPressed){
      startfrag1 = false;
      startfrag2 = false; 
    }
    if(!startfrag1 && !startfrag2){
      if(balldx >= 12){
        balldx -= random(2,4);
      }else if(balldx <= -12){
        balldx += random(2,4);
      }
      if(balldy >= 15){
        balldy -= random(7,15);
      }else if(balldy<=-15){
        balldy += random(7,15);
      }
      balldx *= -1;
      scene = 4;
    }
  }
}


//以下Q学習用コード

void startQ(){
  for(int i=0;i<41;i++){
    for(int j=0;j<3;j++){
      Q[i][j] = 0;
    }
  }
}

int getstate(){
  int state = (bally-racket2)/30;
  state += 21;
  if (state<0){
    state = 0;
  }else if(state > 40){
    state = 40;
  }
  return state;
}

int chooseaction(int state){
  if(random(1)<epsilon){
    return int(random(3))-1;
  }else{
    return calculateQmax(Q[state]) -1;
  }
}

int calculateQmax(float[] action){
  int bestaction = 0;
  for(int i=1;i<action.length;i++){
    if(action[i]>action[bestaction]){
      bestaction = i;
    }
  }
  return bestaction;
}

void updateQ(int state,int action, float reward,int nextstate){
  float maxQnext = max(Q[nextstate]);
  Q[state][action+1] += alpha*(reward+gamma*maxQnext-Q[state][action+1]);
}

void processing_AI_learning(){
  for(int i=0;i<1000000;i++){
    racket2 = 400;
    ballx = 500;
    bally = 400;
    balldx = int(random(7,20));
    balldy = int(random(-15,15));
    int state = getstate();
    for(int j=0;j<10000;j++){
      int action = chooseaction(state);

      racket2 += action*15;
      if(racket2<50){
        racket2 = 50;
      }else if(racket2>750){
        racket2 = 750;
      }
      
      ballx += balldx;
      bally += balldy;
      if(bally<=10 || bally>=790){
        balldy *= -1;
      }
      
      if(ballx >= 970 && ballx <= 970 + balldx){
        if(bally >= racket2 - 30 && bally <= racket2 + 30){
          balldx *= -1;
        }
      }

      int reward = calculatereward();
      int nextstate = getstate();

      updateQ(state, action, reward, nextstate);

      state = nextstate;
      
      if(ballx<=0 || ballx>=1000){
        break;
      }
    }
  }
}

int calculatereward(){
  if(ballx>=970-10 && ballx<=970 + 10 && bally>=racket2 - 70 && bally<=racket2 + 70){
    return 1;
  }else if(ballx >= 1000){
    return -1;
  }
  return 0;
}

void singleplayAI(){
  int state = getstate();
  int action = chooseaction(state);

  racket2 += action*15;
  if(racket2<50){
    racket2 = 50;
  }else if(racket2>750){
    racket2 = 750;
  }
}