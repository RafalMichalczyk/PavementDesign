# PavementDesign
**Structural analysis of pavement with consideration of inelastic material properties of structural layers. Formulation and numerical implementation of non-classical constitutive models of asphalt-aggregate mixes for elastic-viscoplastic deformations.**
<p align="center">
  <img style="width : auto;height: 345px;" src="https://github.com/RafalMichalczyk/PavementDesign/blob/main/imgs/pavement_design_cover_pl.jpg?raw=false" alt="Book cover"/>
</p> 
[Rafał Michalczyk, Artur Zbiciak "Modelowanie efektów niesprężystych w nawierzchniach asfaltowych. Opis konstytutywny i symulacje numeryczne"](http://www.wydawnictwopw.pl/index.php?s=karta&id=3689)

### Abstract
Primary objective of this research was the formulation of constitutive equations of elasto-visco-plastic materials, which can be used in numerical simulation of flexible pavement. Commonly used elastic model cannot adequately predict pavement performance taking into consideration temperature, duration and intensity of loading. This was the motivation to improve material modeling and characterization techniques. 

The procedure of the formulation of constitutive equations for asphalt-aggregate mixes is based on rheological schemes composed of classical elastic, viscous and plastic elements. The thesis presents the proposition of an original rheological schemes based on Maxwell model and including plasticity. The method uses phenomenological approach and is well suited for the modelling of viscoplastic deformations. 

The commercial FEM software ABAQUS was used for the implementation of the models. The user subroutines allow the program to be customized for particular applications. In this case UMAT, written as FORTRAN code, was used for the implementation of custom algorithm for the integration of constitutive eqautions. Since the verification of implementation is vital, a series of single element tests were performed. 

The viscoelastic parameters were identified using cyclic test (DMA) at various temperatures. The temperature-time superposition principle was applied in order to reduce the experimental data to single curve (mastercurve) covering a wide range of frequencies at a chosen reference temperature. In order to find the parameters of rheological schemes the optimization problem was formulated and the solution obtained using least-squares methods implemented in custom software. 

Important stage in mechanistic-empirical pavement design method is to determine the stress and strain states under single wheel loading. For this reason a software, implementing linear elastic multi-layered Burmister theory, was created. This analytical method was a benchmark for comparison with numerical solutions of initial-boundary-value problems. 

The developed constitutive relations have been used for the dynamical FE analysis of flexible pavement under moving load in three cases. It was shown how axis-symmetrical model can be improved. Calculation for an airport pavement were carried out using 3D model. Submodeling method was employed to study bridge deck pavement mechanical response. The results presented show that mathematical models developed may be used by engineers and researchers to estimate flexible pavement performance. The last chapter contains concluding remarks and describes future research needs. 
