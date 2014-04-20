
var strings = loadStrings('data.json');

var data = JSON.parse(strings.join(''));
void setup(){
size(500,400);
}

void draw(){
for(int i = 0; i < data.length;i++){
  rect(data[i].x, data[i].y,10,10);

  }

}

