M4 drug discovery exemplified with GLP1-R agonist exenatide.

All scripts, functions, models, and data used for the analysis is included in these files. Please run scripts through the script called "main" which ensures that all data and variables are loaded properly. Scripts have been created to make it easy to plot all figures used in article, see "PlotInvitroSystems.m", "PlotPharmacokineticTranslation.m" etc.
To be able to plot all functions you need:
1. A comparable complier (for example MinGW64 Compiler)
2. IQM toolbox installed (see IQM toolbox folder included in the main folder).
3. Deep learning toolbox (only for one calculation, which is done and saved for you in 'ExenatideParamMatrix_population'. Therefore you only need to download it if you want to rerun the calculation)
4. Parallel computering toolbox (strong recommendation if you want to re run optimisaiton. If you dont have acces to it then you can do so using only one CPU cure, but it will take longer time. To only use one core use 'options2' on line 53 instead of 54 in the 'LoadAll' script.
5. Optimisation toolbox (only if you want to re run optimisaiton).
6. Global optimisation toolbox (only if you want to re run optimisaiton).

To plot everything from the manuscript simply press "run" through the main script.

If needed, please contact Oscar.Silfvergren@liu.se for any questions.

Best regards, Oscar Silfvergren