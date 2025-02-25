# Double Pendulum on a Cart Equilibrium Transition Solver
Author: Marvin Ahlborn
Date: 2025-02-25

This code solves the two-point boundary value problem (TPBVP) that is the
necessary optimality conditions for the double pendulum on a cart. They
have been derived in dynamics.mlx using implicit optimal control theory
(calculus of variations). flow is the function that propagates the
augmented state y (state and costate) and computes the state transition
matrix (analytical derivates) using the variational approach for
propagating it alongside y. 156 ODEs have to be integrated in total (12
for y and 144 for the STM).

Generally an implicit optimal control problem is solved by finding the
initial costate lambda(t0) that results in satisfying the boundary
condition x(tf) = xf. This is usually done by using simple
single-shooting. This is hard however because of the small lambda0
convergence radius and no way of guessing lambda0 using intuition as it
lacks physical meaning.

This is why multiple shooting was used here. It improves the convergence
slightly. The initial guess was supplied by a logarithmic random search
procedure that tries out lambda0 over multiple orders of magnitude until
it finds one that is close to the optimal solution by chance. Only then
multiple shooting is employed. This was done to minimize the time wasted
on obviously unpromising initial guesses. The initial guess lambda0 is
propagated and the states at the multiple shooting segment times are
taken as initial guess for its decision vector z.

Parallelization was used for looking for initial guesses. Four processes
employed random search and then multiple shooting independently and wrote
the results in a separate file each.

Lessons learned:
Multiple shooting can't do miracles: It's better than single shooting but
finding a solution is still dependent on a good initial guess.

More multiple shooting segments don't mean better convergence: The sweet
spot was found to be 4 segments. Less means slower convergence because of
higher non-linearities in each segment but a lot more segments also led
to slower convergence, not only because each step took longer, but also
the number of steps increased somehow. This is all very heuristic, more
research has to be done.

Supply analytical gradients! This allows using less strict integration
tolerances which makes everything faster.

Don't waste time on unpromising initial guesses: Sometimes it's better to
wait a few minutes for a finding a good initial guess by chance than to
waste minutes by trying to optimize obviously bad initial guesses.

Scaling is important: x and lambda can have wildely different orders of
magnitude so they have to be scaled accordingly for multiple shooting to
converge. Finding the order of magnitude of lambda (which can vary quite
a bit) is not easy. One advice is to visualize the problem (animation in
this case) and manually tweak each lambda component individually until a
good control effort is found. The system has to visibly do something but
shouldn't explode immediately as soon as you press run. Use this value
for normalization.

Don't make the problem impossible: Sometimes the boundary conditions are
chosen such that the problem is impossible to solve. E.g. setting the
final time too low in the pendulum case. The system is inheritely
constrained by the speed of its physics, you can't expect miracles from
the solver. Especially if the solver regularly ends with "Last step of
ineffective" and it doesn't find solutions it might be a sign that you
might need to change your problem (In the pendulum case just giving it
more time for the transfers).
