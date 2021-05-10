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


minimize sum (n1 in N, n2 in N, t in T) S[n1][n2] * sum (r in R) NTR[n1][t][r] * NTR[n2][t][r]; // Write here the objective function.

subject to {
  
	forall (n in N)
	  sum (t in T, r in R) NTR[n][t][r] == 1;
	  
	forall (t in T, r in R)
	  sum (n in N) NTR[n][t][r] <= 1;
	
	forall (n1 in N, n2 in N, t in T)
	  P[n1][n2] * (sum (r in R) NTR[n1][t][r] + sum (r in R) NTR[n2][t][r]) <= 1;
	
	forall (n1 in N, n2 in N, t1 in T, t2 in T)
	  P[n1][n2] * sum (r in R) NTR[n1][t1][r] * NTR[n2][t2][r] * (t1 - t2) <= d; //!!
	  
}

execute {

  var slotOfTalk = new Array(n+1);
  var roomOfTalk = new Array(n+1);
  var talkOfSlotRoom = new Array(t+1);
  for (var i in T) talkOfSlotRoom[i] = new Array(r+1);
  for (var i in T) for (var k in R) talkOfSlotRoom[i][k] = 0;

  // Populate here arrays slotOfTalk, roomOfTalk, talkOfSlotRoom.

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
