# Geometry — A Journey

A self-contained tour of geometry, built as a sequence of Maxima notebooks. The spine is **Klein's Erlangen program**: a geometry is a space, a group of transformations, and the quantities those transformations leave alone. The arc runs from **Euclidean and affine geometry** (first-year material — vectors, isometries, conics), through **projective and non-Euclidean geometry** (the same space, different groups), into the **classical differential geometry of curves and surfaces**, then **Riemannian geometry**, and finally **Lie groups, bundles, and curvature as a physical field**.

Each notebook pairs **definitions and proofs** with **explicit computation** — symmetry groups enumerated, conics diagonalised, curvature tensors derived symbolically, geodesics integrated numerically, surfaces plotted. The emphasis throughout is that curvature and symmetry are computable things, not just formal ones.

This repo is a companion to [topology-journey](https://github.com/cmsd2/topology-journey) and [analysis-journey](https://github.com/cmsd2/analysis-journey), which build the smooth-manifold machinery abstractly. Here we assume that machinery and use it to measure things: lengths, angles, areas, and curvature.

## Prerequisites

**Mathematical:** Stages 1–2 need only school algebra and trigonometry, plus enough linear algebra to diagonalise a symmetric matrix ([linalg-journey](https://github.com/cmsd2/linalg-journey) Stages 1–3). Stage 3 needs multivariable calculus (partial derivatives, the chain rule, surface integrals — [analysis-journey](https://github.com/cmsd2/analysis-journey) Stage 2). Stage 4 onwards assumes smooth manifolds, tangent bundles and differential forms; Stage 4.00 recaps what is needed and links to [topology-journey Stage 3](https://github.com/cmsd2/topology-journey) for the full treatment.

**Computational:**
```
mxpm install numerics
mxpm install ax-plots
```

Some notebooks load:
```maxima
load("numerics")$            /* ndarrays, matrix computations */
load("numerics-integrate")$  /* np_odeint — geodesic integration */
load("ax-plots")$            /* curve and surface visualisations */
load("ctensor")$             /* component tensors: Christoffel symbols, Riemann tensor */
load("itensor")$             /* indicial tensors: symmetries, Bianchi identities */
```

`ctensor` and `itensor` ship with Maxima and are the reason Stages 4–6 are tractable: Christoffel symbols, the Riemann and Ricci tensors, and the Einstein tensor all come out symbolically from a metric.

## The Journey

### Stage 1 — Euclidean and Affine Geometry

Geometry as most people first meet it, done properly: distance and angle, the transformations that preserve them, and the symmetry groups that result.

| # | Notebook | Idea |
|---|----------|------|
| 01 | [vectors-lines-and-planes](notebooks/01-euclidean-and-affine/01-vectors-lines-and-planes.macnb) | Dot, cross and triple products; parametric vs implicit descriptions; distance from a point to a line, a plane, and between skew lines |
| 02 | [isometries-of-the-plane](notebooks/01-euclidean-and-affine/02-isometries-of-the-plane.macnb) | Translations, rotations, reflections, glide reflections; every plane isometry is a product of at most three reflections; classification by fixed points |
| 03 | [rotations-of-space-and-quaternions](notebooks/01-euclidean-and-affine/03-rotations-of-space-and-quaternions.macnb) | $SO(3)$; Euler's theorem (every rotation has an axis); axis-angle, Euler angles and their singularities; unit quaternions as a double cover |
| 04 | [symmetry-groups](notebooks/01-euclidean-and-affine/04-symmetry-groups.macnb) | Finite subgroups of $SO(3)$; symmetry groups of the Platonic solids; frieze and wallpaper groups; why there are exactly 17 |
| 05 | [affine-geometry-and-barycentric-coordinates](notebooks/01-euclidean-and-affine/05-affine-geometry-and-barycentric-coordinates.macnb) | Affine maps and what they preserve (ratios, parallelism, centroids); barycentric coordinates; Ceva and Menelaus computed |
| 06 | [conics-and-quadrics](notebooks/01-euclidean-and-affine/06-conics-and-quadrics.macnb) | Classification by the eigenvalues of the quadratic form; principal axes as an eigenvector problem; degenerate cases; quadric surfaces in $\mathbb R^3$ |
| 07 | [euclidean-invariants](notebooks/01-euclidean-and-affine/07-euclidean-invariants.macnb) | What the Euclidean group actually preserves; invariants as the thing a geometry is *about* — the setup for Stage 2 |

### Stage 2 — Projective, Inversive and Non-Euclidean Geometry

Keep the space, change the group, and you get a different geometry. Parallel lines meet, circles become lines, and the angles of a triangle stop summing to $\pi$.

| # | Notebook | Idea |
|---|----------|------|
| 01 | [the-erlangen-program](notebooks/02-projective-and-non-euclidean/01-the-erlangen-program.macnb) | Klein's thesis: geometry = space + transformation group + invariants; the lattice of geometries ordered by subgroup inclusion |
| 02 | [the-projective-plane](notebooks/02-projective-and-non-euclidean/02-the-projective-plane.macnb) | Homogeneous coordinates; $\mathbb{RP}^2$ as $\mathbb R^2$ plus a line at infinity; every two lines meet; duality of points and lines |
| 03 | [cross-ratio-and-projectivities](notebooks/02-projective-and-non-euclidean/03-cross-ratio-and-projectivities.macnb) | $PGL(3)$; the cross-ratio as *the* projective invariant; the fundamental theorem; perspective drawing as an application |
| 04 | [conics-projectively](notebooks/02-projective-and-non-euclidean/04-conics-projectively.macnb) | All non-degenerate conics are projectively equivalent; Pascal's and Brianchon's theorems; poles and polars |
| 05 | [inversive-geometry-and-mobius-maps](notebooks/02-projective-and-non-euclidean/05-inversive-geometry-and-mobius-maps.macnb) | Inversion in a circle; circles-to-circles; $PSL(2,\mathbb C)$ acting on the Riemann sphere; stereographic projection |
| 06 | [hyperbolic-geometry](notebooks/02-projective-and-non-euclidean/06-hyperbolic-geometry.macnb) | Upper half-plane and Poincaré disc models; hyperbolic distance and area; triangles with angle *deficit*; tilings and $PSL(2,\mathbb R)$ |
| 07 | [spherical-and-elliptic-geometry](notebooks/02-projective-and-non-euclidean/07-spherical-and-elliptic-geometry.macnb) | Spherical trigonometry; area = angular excess; the three constant-curvature geometries side by side, distinguished only by their group |

### Stage 3 — Curves and Surfaces in $\mathbb R^3$

Classical differential geometry, in the style of do Carmo. Concrete, computational, and the place where curvature first appears as a number you can calculate.

| # | Notebook | Idea |
|---|----------|------|
| 01 | [curves-arclength-and-curvature](notebooks/03-curves-and-surfaces/01-curves-arclength-and-curvature.macnb) | Regular curves; reparametrisation by arc length; curvature as the rate of turning of the unit tangent |
| 02 | [frenet-serret-and-torsion](notebooks/03-curves-and-surfaces/02-frenet-serret-and-torsion.macnb) | The moving frame $(T, N, B)$; torsion; the fundamental theorem of curves — curvature and torsion determine a curve up to rigid motion |
| 03 | [surfaces-and-the-first-fundamental-form](notebooks/03-curves-and-surfaces/03-surfaces-and-the-first-fundamental-form.macnb) | Parametrised surfaces and tangent planes; the first fundamental form as the induced metric; lengths, angles and areas *on* the surface |
| 04 | [the-gauss-map-and-second-fundamental-form](notebooks/03-curves-and-surfaces/04-the-gauss-map-and-second-fundamental-form.macnb) | The Gauss map and its differential; the shape operator; normal curvature; principal curvatures and directions as an eigenvalue problem |
| 05 | [gaussian-and-mean-curvature](notebooks/03-curves-and-surfaces/05-gaussian-and-mean-curvature.macnb) | $K = \kappa_1\kappa_2$ and $H = (\kappa_1+\kappa_2)/2$; elliptic, hyperbolic and parabolic points; surfaces of revolution computed in full |
| 06 | [theorema-egregium](notebooks/03-curves-and-surfaces/06-theorema-egregium.macnb) | Christoffel symbols in two dimensions; the Gauss and Codazzi–Mainardi equations; Gauss's remarkable theorem — $K$ depends only on the first fundamental form |
| 07 | [geodesics-on-surfaces](notebooks/03-curves-and-surfaces/07-geodesics-on-surfaces.macnb) | Geodesic curvature; the geodesic equations as a nonlinear ODE system, integrated numerically; the exponential map and normal coordinates |
| 08 | gauss-bonnet | The local theorem, then the global one: $\int_M K \, dA + \int_{\partial M} \kappa_g \, ds = 2\pi\chi(M)$ — curvature is constrained by topology |
| 09 | minimal-surfaces | $H = 0$; soap films; the catenoid, helicoid and Enneper surface; Plateau's problem as a signpost |

### Stage 4 — Riemannian Geometry

Curvature without an ambient space. Everything in Stage 3 was measured from outside $\mathbb R^3$; here the metric is all there is.

| # | Notebook | Idea |
|---|----------|------|
| 00 | manifolds-recap | The minimum needed: charts, tangent vectors as derivations, vector fields, forms. A recap and a map — the full development is in [topology-journey Stage 3](https://github.com/cmsd2/topology-journey) |
| 01 | riemannian-metrics | Metrics as smoothly varying inner products; length, distance and volume; the round sphere, the hyperbolic plane and flat tori as running examples |
| 02 | connections-and-covariant-differentiation | Why $\partial_i V^j$ is not a tensor; affine connections; parallel transport; the Levi-Civita connection and its Christoffel symbols, derived symbolically |
| 03 | geodesics-and-the-exponential-map | Geodesics as straightest and as shortest; the exponential map; normal coordinates; geodesic completeness and Hopf–Rinow |
| 04 | the-curvature-tensor | Curvature as the failure of covariant derivatives to commute; the Riemann tensor via `ctensor`; its symmetries and the Bianchi identities |
| 05 | sectional-ricci-and-scalar-curvature | Contractions of Riemann and what each one measures; sectional curvature and its relation to Stage 3's $K$; Ricci as volume distortion |
| 06 | jacobi-fields-and-comparison | Variations through geodesics; conjugate points; Bonnet–Myers and Cartan–Hadamard — curvature bounds forcing global topology |
| 07 | space-forms-and-constant-curvature | Classification of constant-curvature spaces; the sphere, Euclidean space and hyperbolic space as the only simply connected models; back to Stage 2 |

### Stage 5 — Lie Groups, Bundles and Curvature as a Field

Symmetry groups become geometric objects in their own right, and curvature is reinterpreted as a field strength.

| # | Notebook | Idea |
|---|----------|------|
| 01 | matrix-lie-groups-and-lie-algebras | $GL_n$, $SO(n)$, $SU(n)$, $Sp(n)$ as manifolds; the Lie algebra as the tangent space at the identity; the bracket |
| 02 | the-exponential-map-and-adjoint | $\exp$ for matrix groups; one-parameter subgroups; $\mathrm{Ad}$ and $\mathrm{ad}$; the Baker–Campbell–Hausdorff formula |
| 03 | invariant-metrics-and-homogeneous-spaces | Left- and bi-invariant metrics; the Killing form; $G/H$ as a manifold; spheres, projective spaces and Grassmannians as homogeneous spaces |
| 04 | symmetric-spaces | Geodesic symmetries; curvature from the Lie bracket alone; the compact/non-compact duality |
| 05 | principal-bundles-and-connections | Principal $G$-bundles; connections as $\mathfrak g$-valued forms; curvature $F = dA + A \wedge A$; gauge transformations; the Levi-Civita connection as a special case |
| 06 | characteristic-classes | Chern–Weil theory: invariant polynomials in the curvature give de Rham classes; Chern, Pontryagin and Euler classes; Gauss–Bonnet–Chern as the payoff |

### Stage 6 — Geometry in the Wild

Where the machinery gets used. These are largely independent — read what you want.

| # | Notebook | Idea |
|---|----------|------|
| 01 | lorentzian-geometry | Signature $(-,+,+,+)$; causal structure, light cones, proper time; Minkowski space and the Lorentz group |
| 02 | schwarzschild-and-the-tests-of-gr | The Einstein equations; solving for the Schwarzschild metric with `ctensor`; light bending, perihelion precession, the event horizon as a coordinate artefact |
| 03 | symplectic-geometry-and-mechanics | Symplectic forms; Darboux's theorem (no local invariants); Hamiltonian flows, Poisson brackets, moment maps — the geometric backbone of [control-systems-journey](https://github.com/cmsd2/control-systems-journey) |
| 04 | complex-and-kahler-geometry | Complex manifolds and Riemann surfaces; Hermitian and Kähler metrics; the Fubini–Study metric on $\mathbb{CP}^n$ |
| 05 | information-geometry | The Fisher information metric; statistical models as Riemannian manifolds; dual connections; the exponential family as a flat geometry |
| 06 | discrete-differential-geometry | Curvature on triangle meshes; angle defect as discrete $K$; the cotangent Laplacian; discrete Gauss–Bonnet holding exactly |
| 07 | where-next | Honest signposts: index theory, Ricci flow and the Poincaré conjecture, geometric analysis, metric geometry in the sense of Gromov |

## Reading Order

Stages 1–2 stand alone and need almost nothing. Stage 3 is the hinge — it can be read directly after Stage 1 if you have multivariable calculus, but Stage 2 makes the constant-curvature story in 3.08 and 4.07 land properly. Stages 4–5 are sequential. Stage 6 is a menu.

A short "must-read" path:

> 1.02 → 1.06 → 2.01 → 2.06 → 3.03 → 3.05 → 3.06 → 3.08 → 4.01 → 4.02 → 4.04 → 4.05 → 5.05

A "shape of surfaces only" path, stopping at the classical material:

> 1.01 → 1.06 → 3.01 → 3.03 → 3.04 → 3.05 → 3.06 → 3.07 → 3.08

## Relationship to Other Journeys

- **[topology-journey](https://github.com/cmsd2/topology-journey):** builds smooth manifolds, differential forms, de Rham cohomology and Stokes' theorem from the ground up. That is the prerequisite for Stage 4 here, and Stage 4.00 links back to it rather than repeating it. Its Euler characteristic is what Gauss–Bonnet (3.08) computes geometrically.
- **[analysis-journey](https://github.com/cmsd2/analysis-journey):** Stage 2 (multivariable calculus) is the direct prerequisite for Stage 3 here.
- **[linalg-journey](https://github.com/cmsd2/linalg-journey):** eigenstructure and quadratic forms drive Stage 1.06 and 3.04; multilinear algebra underlies every tensor in Stages 4–5.
- **[control-systems-journey](https://github.com/cmsd2/control-systems-journey):** Stage 6.03 (symplectic geometry) is the geometric account of the Hamiltonian mechanics that optimal control rests on.

## Further Reading

**Undergraduate companions (Springer UTM).** These sit at the level this journey starts from:

- Stillwell, J. (2005) *The Four Pillars of Geometry*. Undergraduate Texts in Mathematics. New York: Springer. [doi:10.1007/0-387-29052-4](https://doi.org/10.1007/0-387-29052-4) — the closest single companion. Its four pillars — straightedge-and-compass, linear algebra, projective geometry, transformation groups — are the Erlangen spine of Stages 1–2, and each is given a concrete chapter followed by an abstract one.
- Martin, G.E. (1982) *Transformation Geometry: An Introduction to Symmetry*. Undergraduate Texts in Mathematics. New York: Springer. [doi:10.1007/978-1-4612-5680-9](https://doi.org/10.1007/978-1-4612-5680-9) — Stage 1, especially 1.02 and 1.04.
- Samuel, P. (1988) *Projective Geometry*. Undergraduate Texts in Mathematics / Readings in Mathematics. New York: Springer. ISBN 978-0-387-96752-3 — Stage 2.02–2.04.
- Lee, N.-H. (2020) *Geometry: from Isometries to Special Relativity*. Undergraduate Texts in Mathematics. Cham: Springer. [doi:10.1007/978-3-030-42101-4](https://doi.org/10.1007/978-3-030-42101-4) — Stages 1–2 and 6.01.

**A level up (Universitext).**

- Audin, M. (2003) *Geometry*. Universitext. Berlin: Springer. [doi:10.1007/978-3-642-56127-6](https://doi.org/10.1007/978-3-642-56127-6) — affine, Euclidean and projective geometry, conics and quadrics, curves and surfaces: Stages 1–3 in one book.
- Richter-Gebert, J. (2011) *Perspectives on Projective Geometry*. Berlin: Springer. [doi:10.1007/978-3-642-17286-1](https://doi.org/10.1007/978-3-642-17286-1) — projective geometry as the common parent of the Euclidean, hyperbolic, elliptic and relativistic geometries.

**Graduate, for the later stages.**

- Lee, J.M. (2018) *Introduction to Riemannian Manifolds*. Cham: Springer. [doi:10.1007/978-3-319-91755-9](https://doi.org/10.1007/978-3-319-91755-9) — Stage 4.
- Tu, L.W. (2017) *Differential Geometry: Connections, Curvature, and Characteristic Classes*. GTM 275. Cham: Springer. [doi:10.1007/978-3-319-55084-8](https://doi.org/10.1007/978-3-319-55084-8) — Stage 5, through to Chern–Weil.
- Naber, G.L. (1997) *Topology, Geometry, and Gauge Fields*. New York: Springer. [doi:10.1007/978-1-4757-2742-5](https://doi.org/10.1007/978-1-4757-2742-5) — Stage 5.05–5.06.
- Callahan, J.J. (2000) *The Geometry of Spacetime*. New York: Springer. [doi:10.1007/978-1-4757-6736-0](https://doi.org/10.1007/978-1-4757-6736-0) — Stage 6.01–6.02.

Per-notebook references appear at the foot of each notebook.

## Sources and Verification

Every code cell in every notebook has been executed, and the output shown is the real result — the symbolic identities, classifications and counts are checked by Maxima rather than asserted. Where a claim can be turned into a computation, it has been.

The prose is written from knowledge and cross-checked against the references listed at the foot of each notebook. Texts marked ★ there are ones held locally; the rest are standard works cited as further reading rather than consulted line by line. Historical dates and attributions are given only where they are unambiguous — where sources disagree (Euler's rotation memoir, presented 1775 and published 1776, is the case in Stage 1) the notebook says so instead of picking one.

## Scope

The journey aims at first-year-graduate level and stops there deliberately. Chern–Weil theory and a fully computed Schwarzschild solution are the intended ceiling. Index theory, Ricci flow and geometric analysis are signposted in 6.07, not covered.

## License

[CC0 1.0](LICENSE)
