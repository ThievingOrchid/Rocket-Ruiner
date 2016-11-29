public class Platform{
  int wide,high,left,top,bot,right;
  color platColor=color(0,0,255);
  Platform(int left, int top,int wide, int high){
    this.wide=wide;
    this.high=high;
    this.left=left;
    this.top=top;
    this.bot=top+high;
    this.right=left+wide;
  }
  
  void paint(){
    fill(platColor);
    rect(left,top,wide,high);
  }
}