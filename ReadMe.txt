M4 drug discovery exemplified with GLP1-R agonist exenatide.

All scripts, functions, models, and data used for the analysis is included in these files. Please run scripts through the script called "main" which ensures that all data and variables are loaded properly. Scripts have been created to make it easy to plot all figures used in article, see "PlotInvitroSystems.m", "PlotPharmacokineticTranslation.m" etc.
To be able to run all code you need:
1. A comparable complier (e.g. MinGW64 Compiler).
2. IQM toolbox (which is included herein; see IQM toolbox folder).
3. Deep learning toolbox (used for one calculation. Calculation is saved in 'ExenatideParamMatrix_population'. Therefore, you only need to download it if you want to re-run the calculation).
4. Parallel computering toolbox (Recommended if you want to re-run the parameter estimation. If you dont have access to it then you can do the estimation using only one CPU cure - but it will take significantly longer time. To only use one core use 'options2' on line 53 instead of 54 in the 'LoadAll' script).
5. Optimisation toolbox (only if you want to re-run optimisation).
6. Global optimisation toolbox (only if you want to re-run optimisaiton).

To plot everything from the manuscript simply press "run" through the main script.

If needed, please contact Oscar.Silfvergren@liu.se for any questions.

Best regards, Oscar Silfvergren

Abstract 
Drug discovery utilises cell- and animal-systems to predict human responses. These different systems provide different drug discovery insights. However, there is currently no methodology to integrate all these insights into single quantitative framework. This study presents a new methodology — M4 drug discovery — which achieves such an integration. The method integrates: a) Multi-timescale data (short- to long-term responses); b) Multi-level data (intracellular to whole-organism responses); c) Mechanistic models (describing mechanistic underpinning); d) Multi-species data (for example rodent and monkey responses). We exemplify this new method using 16 new human cell culture studies, 6 pre-existing human cell culture studies, and 6 pre-existing in vivo studies of the glucagon-like peptide-1 receptor agonist exenatide. All data can be simultaneously explained, and we successfully predict new human cell culture studies (χ2=64<83, p=0.05), human pharmacokinetics (χ2=64<97, p=0.05), and human drug responses (χ2=36<45, p=0.05). We found that different systems contribute complementary insights by predicting a 30-week human exenatide treatment study: multi-species data provides pharmacokinetics; human cell data provides human potency readings; and animal data provides drug effects, such as appetite changes, which could not be observed in our human cell culture studies. Our method opens the door to more cost-effective, ethical, and knowledge-based drug discovery.
