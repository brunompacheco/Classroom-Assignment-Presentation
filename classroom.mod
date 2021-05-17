set C;
set T;
set R;
set L;
set P;

set L_c {C};
set R_p {P};
set R_c {C};
set P_c {C};
set P_l {L};
set P_rt {R,T};

# param w {P,R};
param w {P};

var x {P,R} binary;

# maximize AssignmentQuality: sum {p in P, r in R} (w[p,r] * x[p,r]);
maximize AssignmentQuality: sum {p in P, r in R} (w[p] * x[p,r]);

subject to RoomOverbooking {r in R, t in T}:
    sum {p in P_rt[r,t]} (x[p,r]) <= 1;

subject to LectureOverbooking {l in L}:
    sum {p in P_l[l]} (sum {r in R_p[p]} (x[p,r])) <= 1;

subject to PatternUnity {c in C, r in R_c[c]}:
    sum{p in P_c[c]} (x[p,r]) <= 1;

subject to InfeasibleRooms {p in P}:
    sum {r in R diff R_p[p]} x[p,r] = 0;
