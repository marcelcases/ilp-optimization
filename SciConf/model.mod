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
dvar boolean NT[N][N][T];
dvar boolean AUX[N][N][T][T];

// You can run an execute block if needed.

// Write here the objective function.
minimize 1/2 * sum(i1 in N, i2 in N, j in T) S[i1][i2] * NT[i1][i2][j];

subject to {
  
    // Constraint I
	forall (i in N)
	  sum (j in T, k in R) NTR[i][j][k] == 1;
	  
  	// Constraint II
	forall (j in T, k in R)
	  sum (i in N) NTR[i][j][k] <= 1;
	
    // Constraint III
	forall (i1 in N, i2 in N, j in T)
	  NT[i1][i2][j] >= -1+sum (k in R) (NTR[i1][j][k] + NTR[i2][j][k]);
	  
	forall (i1 in N, i2 in N, j in T)
	  NT[i1][i2][j] * P[i1][i2] <= 0;
	
    // Constraint IV
    //Aux variable
    forall (i1 in N, i2 in N, j1 in T, j2 in T)
	  AUX[i1][i2][j1][j2] >= -1+sum (k in R) (NTR[i1][j1][k] + NTR[i2][j2][k]);
    
	forall (i1 in N, i2 in N, j1 in T, j2 in T)
	   AUX[i1][i2][j1][j2]  * P[i1][i2] * pow((j1-j2),2) <= pow(d,2);
	

	 // Constraint V (objective)
	 /* No fa falta
	 z >= 1-sum (i1 in N, i2 in N, j in T, k1 in R, k2 in R) (1-NTR[i1][j][k1] + 1-NTR[i2][j][k2] + 1-S[i1][i2]); 
	 */
}

execute {

  var slotOfTalk = new Array(n+1);
  var roomOfTalk = new Array(n+1);
  var talkOfSlotRoom = new Array(t+1);
  for (var i in T) talkOfSlotRoom[i] = new Array(r+1);
  for (var i in T) for (var k in R) talkOfSlotRoom[i][k] = 0;

  // Populate here arrays slotOfTalk, roomOfTalk, talkOfSlotRoom.
  var i = 0
  for (var i in N){
    for (var j in T){
      for(var r in R){
        if(NTR[i][j][r] > 0){
          //registrar slot
          slotOfTalk[i] = j;
          //registrar room
          roomOfTalk[i] = r;
          //talk of slot
          talkOfSlotRoom[j][r] = i;
        }
      }
    }
  }

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
