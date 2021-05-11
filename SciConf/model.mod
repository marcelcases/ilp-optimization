// PLEASE ONLY CHANGE THIS FILE WHERE INDICATED.

int n = ...;
int t = ...;
int r = ...;
int d = ...;

range N = 1..n;
range T = 1..t;
range R = 1..r;

int P[N][N] = ...;
int S[N][N] = ...;

// Define here your decision variables and any other auxiliary data.
dvar boolean NTR[N][T][R];

// You can run an execute block if needed.

// Write here the objective function.
minimize sum (i1 in N, i2 in N, j in T, k1 in R, k2 in R) NTR[i1][j][k1] * NTR[i2][j][k2] * S[i1][i2];

subject to {
  
	forall (i in N)
	  sum (j in T, k in R) NTR[i][j][k] == 1;
	  
	forall (j in T, k in R)
	  sum (i in N) NTR[i][j][k] <= 1;
	
	forall (j in T)
	  sum (i1 in N, i2 in N, k1 in R, k2 in R) (NTR[i1][j][k1] + NTR[i2][j][k2]) * P[i1][i2] <= 1;
//	
//	forall (i1 in N, i2 in N, j1 in T, j2 in T)
//	  sum (k in R) NTR[i1][j1][k] * NTR[i2][j2][k] * P[i1][i2] * (j1 - j2) <= d;
	  
}

execute {

  var slotOfTalk = new Array(n+1);
  var roomOfTalk = new Array(n+1);
  var talkOfSlotRoom = new Array(t+1);
  for (var i in T) talkOfSlotRoom[i] = new Array(r+1);
  for (var i in T) for (var k in R) talkOfSlotRoom[i][k] = 0;

  // Populate here arrays slotOfTalk, roomOfTalk, talkOfSlotRoom.
//  slotOfTalk = 
//  roomOfTalk = 
//  talkOfSlotRoom = 

  writeln();

  for (var j in N) {
    writeln("Talk " + j + " --> slot " + slotOfTalk[j] + ", room " + roomOfTalk[j]);
  }

  writeln();

  for (var k in R) {
    write("\tRoom " + k);
  }

  writeln();
  
  for (var i in T) {
    write("Slot " + i);
    for (var k in R) {
      if (talkOfSlotRoom[i][k] == 0)
        write("\t------");
      else
        write("\tTalk " + talkOfSlotRoom[i][k]);
    }
    writeln();
  }
}
