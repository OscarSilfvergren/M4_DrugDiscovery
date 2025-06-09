function [PersonSpecificParametersEndoC,PersonSpecificParametersInSphero,EndoC_params,InSphero_params] = IndexInSpheroEndoCParamaters(PersonSpecificParameters,AmountParameterOpti,OptimisedParam)

% Where index 1=HC, 2=NC , 3=FCS , 4=B27 , 5=BSA , 6=SM, ULT=7

%% Add parameters that there is only one of
params(	1	) = 	OptimisedParam(	1	)	;%	ISk                               
params(	2	) = 	OptimisedParam(	2	)	;%	IS0                               
params(	3	) = 	OptimisedParam(	3	)	;%	InsulinResistanceUpperlimit       
params(	4	) = 	OptimisedParam(	4	)	;%	InsulinResistanceTimeDependency   
params(	5	) = 	OptimisedParam(	5	)	;%	Fspheroids50                    
params(	6	) = 	OptimisedParam(	6	)	;%	Fspheroids0                     
params(	7	) = 	OptimisedParam(	7	)	;%	Fspheroids_hill                 
params(	8	) = 	OptimisedParam(	8	)	;%	InsulinResponseMax              
params(	9	) = 	OptimisedParam(	9	)	;%	InsulinResponseLactateK         
params(	10	) = 	OptimisedParam(	10	)	;%	InsulinResponse50                
params(	11	) = 	OptimisedParam(	11	)	;%	InsulinResponse_hill            
params(	12	) = 	OptimisedParam(	12	)	;%	Uil_iiK                         
params(	13	) = 	OptimisedParam(	13	)	;%	InsulinClearanceLiverK          
params(	14	) = 	OptimisedParam(	14	)	;%	LactateProductionK              
params(	15	) = 	OptimisedParam(	15	)	;%	GoutK                           
params(	16	) = 	OptimisedParam(	16	)	;%	LactateUk                       
params(	17	) = 	OptimisedParam(	17	)	;%	AllometricLiverScalingK
params(	18	) = 	OptimisedParam(	18	)	;%	AllometricScalingK              
params(	19	) = 	OptimisedParam(	19	)	;%	Fislets50                       
params(	20	) = 	OptimisedParam(	20	)	;%	Filets0                         
params(	21	) = 	OptimisedParam(	21	)	;%	Filets_hill                     
params(	22	) = 	OptimisedParam(	22	)	;%	d0                              
params(	23	) = 	OptimisedParam(	23	)	;%	r1                              
params(	24	) = 	OptimisedParam(	24	)	;%	r2                              
params(	25	) = 	OptimisedParam(	25	)	;%	kv                              
params(	26	) = 	OptimisedParam(	26	)	;%	GlucoseIsletsMediumDiffusion                      
params(	27	) = 	OptimisedParam(	27	)	;%	ExenatideDegradiationK                            
params(	28	) = 	OptimisedParam(	28	)	;%	ExenatideInsulinMax                               
params(	29	) = 	OptimisedParam(	29	)	;%	Exanitide_IP                                      
params(	30	) = 	OptimisedParam(	30	)	;%	ExenatideInsulin50                                
params(	31	) = 	OptimisedParam(	31	)	;%	ExenatideInsulin_hill                             
params(	32	) = 	OptimisedParam(	32	)	;%	ExenatideInsulinDecayMax                          
params(	33	) = 	OptimisedParam(	33	)	;%	ExenatideInsulinDecay50                           
params(	34	) = 	OptimisedParam(	34	)	;%	Exanitide_StabilisationMax                        
params(	35	) = 	OptimisedParam(	35	)	;%	Exanitide_StabilisationIC50                       
params(	36	) = 	OptimisedParam(	36	)	;%	IP_basalK                           
params(	37	) = 	OptimisedParam(	37	)	;%	IP_gdROCk                           
params(	38	) = 	OptimisedParam(	38	)	;%	IP_gdROC_delayK                     
params(	39	) = 	OptimisedParam(	39	)	;%	IP_gdBaselineMax                      
params(	40	) = 	OptimisedParam(	40	)	;%	IP_BaselineK                          
params(	41	) = 	OptimisedParam(	41	)	;%	IP_gdBaseline50                       
params(	42	) = 	OptimisedParam(	42	)	;%	IP_gdBaselineHill                     
params(	43	) = 	OptimisedParam(	43	)	;%	S_max  
params(	44	) = 	OptimisedParam(	44	)	;%	S50    
params(	45	) = 	OptimisedParam(	1	)	;%	ISk                               
params(	46	) = 	OptimisedParam(	2	)	;%	IS0                               
params(	47	) = 	OptimisedParam(	3	)	;%	InsulinResistanceUpperlimit       
params(	48	) = 	OptimisedParam(	4	)	;%	InsulinResistanceTimeDependency   
params(	49	) = 	OptimisedParam(	5	)	;%	Fspheroids50                    
params(	50	) = 	OptimisedParam(	6	)	;%	Fspheroids0                     
params(	51	) = 	OptimisedParam(	7	)	;%	Fspheroids_hill                 
params(	52	) = 	OptimisedParam(	8	)	;%	InsulinResponseMax              
params(	53	) = 	OptimisedParam(	9	)	;%	InsulinResponseLactateK         
params(	54	) = 	OptimisedParam(	10	)	;%	InsulinResponse50                
params(	55	) = 	OptimisedParam(	11	)	;%	InsulinResponse_hill            
params(	56	) = 	OptimisedParam(	12	)	;%	Uil_iiK                         
params(	57	) = 	OptimisedParam(	13	)	;%	InsulinClearanceLiverK          
params(	58	) = 	OptimisedParam(	14	)	;%	LactateProductionK              
params(	59	) = 	OptimisedParam(	15	)	;%	GoutK                           
params(	60	) = 	OptimisedParam(	16	)	;%	LactateUk                       
params(	61	) = 	OptimisedParam(	17	)	;%	AllometricLiverScalingK
params(	62	) = 	OptimisedParam(	45	)	;%	AllometricScalingK              
params(	63	) = 	OptimisedParam(	46	)	;%	Fislets50                       
params(	64	) = 	OptimisedParam(	47	)	;%	Filets0                         
params(	65	) = 	OptimisedParam(	48	)	;%	Filets_hill                     
params(	66	) = 	OptimisedParam(	22	)	;%	d0                              
params(	67	) = 	OptimisedParam(	23	)	;%	r1                              
params(	68	) = 	OptimisedParam(	24	)	;%	r2                              
params(	69	) = 	OptimisedParam(	49	)	;%	kv                              
params(	70	) = 	OptimisedParam(	50	)	;%	GlucoseIsletsMediumDiffusion                      
params(	71	) = 	OptimisedParam(	27	)	;%	ExenatideDegradiationK                            
params(	72	) = 	OptimisedParam(	51	)	;%	ExenatideInsulinMax                               
params(	73	) = 	OptimisedParam(	52	)	;%	Exanitide_IP                                      
params(	74	) = 	OptimisedParam(	53	)	;%	ExenatideInsulin50                                
params(	75	) = 	OptimisedParam(	54	)	;%	ExenatideInsulin_hill                             
params(	76	) = 	OptimisedParam(	55	)	;%	ExenatideInsulinDecayMax                          
params(	77	) = 	OptimisedParam(	56	)	;%	ExenatideInsulinDecay50                           
params(	78	) = 	OptimisedParam(	34	)	;%	Exanitide_StabilisationMax                        
params(	79	) = 	OptimisedParam(	35	)	;%	Exanitide_StabilisationIC50                       
params(	80	) = 	OptimisedParam(	57	)	;%	IP_basalK                           
params(	81	) = 	OptimisedParam(	58	)	;%	IP_gdROCk                           
params(	82	) = 	OptimisedParam(	59	)	;%	IP_gdROC_delayK                     
params(	83	) = 	OptimisedParam(	60	)	;%	IP_gdBaselineMax                      
params(	84	) = 	OptimisedParam(	61	)	;%	IP_BaselineK                          
params(	85	) = 	OptimisedParam(	62	)	;%	IP_gdBaseline50                       
params(	86	) = 	OptimisedParam(	63	)	;%	IP_gdBaselineHill                     
params(	87	) = 	OptimisedParam(	64	)	;%	S_max  
params(	88	) = 	OptimisedParam(	65	)	;%	S50    
params(	89	) = 	OptimisedParam(	66	)	;%	HepaRG_f50(1)   
params(	90	) = 	OptimisedParam(	67	)	;%	HepaRG_f50(2) 
params(	91	) = 	OptimisedParam(	68	)	;%	HepaRG_f50(3)
params(	92	) = 	OptimisedParam(	69	)	;%	HepaRG_f50(4)
params(	93	) = 	OptimisedParam(	70	)	;%	HepaRG_f50(5)
params(	94	) = 	OptimisedParam(	71	)	;%	HepaRG_f0(1)                            
params(	95	) = 	OptimisedParam(	72	)	;%	HepaRG_f0(2)  
params(	96	) = 	OptimisedParam(	73	)	;%	HepaRG_f0(3)  
params(	97	) = 	OptimisedParam(	74	)	;%	HepaRG_f0(4)  
params(	98	) = 	OptimisedParam(	75	)	;%	HepaRG_f0(5)  
params(	99	) = 	OptimisedParam(	76	)	;%	HepaRG_IS(1)  
params(	100	) = 	OptimisedParam(	77	)	;%	HepaRG_IS(2)  
params(	101	) = 	OptimisedParam(	78	)	;%	HepaRG_IS(3)  
params(	102	) = 	OptimisedParam(	79	)	;%	HepaRG_IS(4)  
params(	103	) = 	OptimisedParam(	80	)	;%	HepaRG_IS(5)  
params(	104	) = 	OptimisedParam(	81	)	;%	InsulinResistanceTimeDependency(1) 
params(	105	) = 	OptimisedParam(	82	)	;%	IS0(1)
params(	106	) = 	OptimisedParam(	83	)	;%	Fspheroids0(1)
params(	107	) = 	OptimisedParam(	84	)	;%	Fspheroids50(1)
params(	108	) = 	OptimisedParam(	85	)	;%	Fspheroids_hill(1)
params(	109	) = 	OptimisedParam(	86	)	;%	InsulinResistanceTimeDependency(2) 
params(	110	) = 	OptimisedParam(	87	)	;%	IS0(2)                             
params(	111	) = 	OptimisedParam(	88	)	;%	Fspheroids0(2)                     
params(	112	) = 	OptimisedParam(	89	)	;%	Fspheroids50(2)                    
params(	113	) = 	OptimisedParam(	90	)	;%	Fspheroids_hill(2)                 
params(	114	) = 	OptimisedParam(	91	)	;%	InsulinResistanceTimeDependency(3)
params(	115	) = 	OptimisedParam(	92	)	;%	IS0(3)
params(	116	) = 	OptimisedParam(	93	)	;%	Fspheroids0(3)
params(	117	) = 	OptimisedParam(	94	)	;%	Fspheroids50(3)
params(	118	) = 	OptimisedParam(	95	)	;%	Fspheroids_hill(3)
params(	119	) = 	OptimisedParam(	96	)	;%	InsulinResistanceTimeDependency(4)
params(	120	) = 	OptimisedParam(	97	)	;%	IS0(4)
params(	121	) = 	OptimisedParam(	98	)	;%	Fspheroids0(4)
params(	122	) = 	OptimisedParam(	99	)	;%	Fspheroids50(4)
params(	123	) = 	OptimisedParam(	100	)	;%	Fspheroids_hill(4)
params(	124	) = 	OptimisedParam(	101	)	;%	kv(3)                              
params(	125	) = 	OptimisedParam(	102	)	;%	ExenatideResponse(3)               
params(	126	) = 	OptimisedParam(	103	)	;%	ExenatideResponse50(3)             
params(	127	) = 	OptimisedParam(	104	)	;%	Filets0(3)                         
params(	128	) = 	OptimisedParam(	105	)	;%	Fislets50(3)                       
params(	129	) = 	OptimisedParam(	106	)	;%	Filets_hill(3)                     
params(	130	) = 	OptimisedParam(	107	)	;%	kv(4)                              
params(	131	) = 	OptimisedParam(	108	)	;%	ExenatideResponse(4)               
params(	132	) = 	OptimisedParam(	109	)	;%	ExenatideResponse50(4)             
params(	133	) = 	OptimisedParam(	110	)	;%	Filets0(4)                         
params(	134	) = 	OptimisedParam(	111	)	;%	Fislets50(4)                       
params(	135	) = 	OptimisedParam(	112	)	;%	Filets_hill(4)                     
params(	136	) = 	OptimisedParam(	113	)	;%	ExenatideResponse(5)               
params(	137	) = 	OptimisedParam(	114	)	;%	Fislets50(5)                       
params(	138	) = 	OptimisedParam(	115	)	;%	PersonSpecificParametersInSphero.kv(6)                              
params(	139	) = 	OptimisedParam(	116	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(6)               
params(	140	) = 	OptimisedParam(	117	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(6)             
params(	141	) = 	OptimisedParam(	118	)	;%	PersonSpecificParametersInSphero.Filets0(6)                         
params(	142	) = 	OptimisedParam(	119	)	;%	PersonSpecificParametersInSphero.Fislets50(6)                       
params(	143	) = 	OptimisedParam(	120	)	;%	PersonSpecificParametersInSphero.Filets_hill(6)                     
params(	144	) = 	OptimisedParam(	121	)	;%	PersonSpecificParametersEndoC.kv(7)                              
params(	145	) = 	OptimisedParam(	122	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(7)               
params(	146	) = 	OptimisedParam(	123	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(7)             
params(	147	) = 	OptimisedParam(	124	)	;%	PersonSpecificParametersEndoC.Filets0(7)                         
params(	148	) = 	OptimisedParam(	125	)	;%	PersonSpecificParametersEndoC.Fislets50(7)                       
params(	149	) = 	OptimisedParam(	126	)	;%	PersonSpecificParametersEndoC.Filets_hill(7)                     
params(	150	) = 	OptimisedParam(	127	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(8)              
params(	151	) = 	OptimisedParam(	128	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(9)              
params(	152	) = 	OptimisedParam(	129	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(10)             
params(	153	) = 	OptimisedParam(	130	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(11)             
params(	154	) = 	OptimisedParam(	131	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(12)             
params(	155	) = 	OptimisedParam(	132	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(13)             
params(	156	) = 	OptimisedParam(	133	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(14)             
params(	157	) = 	OptimisedParam(	134	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(15)             
params(	158	) = 	OptimisedParam(	135	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(16)             
params(	159	) = 	OptimisedParam(	136	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(17)             
params(	160	) = 	OptimisedParam(	137	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(18)             
params(	161	) = 	OptimisedParam(	138	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(19)             
params(	162	) = 	OptimisedParam(	139	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(8)            
params(	163	) = 	OptimisedParam(	140	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(9)            
params(	164	) = 	OptimisedParam(	141	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(10)           
params(	165	) = 	OptimisedParam(	142	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(11)           
params(	166	) = 	OptimisedParam(	143	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(12)           
params(	167	) = 	OptimisedParam(	144	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(13)           
params(	168	) = 	OptimisedParam(	145	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(14)           
params(	169	) = 	OptimisedParam(	146	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(15)           
params(	170	) = 	OptimisedParam(	147	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(16)           
params(	171	) = 	OptimisedParam(	148	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(17)           
params(	172	) = 	OptimisedParam(	149	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(18)           
params(	173	) = 	OptimisedParam(	150	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(19)           
params(	174	) = 	OptimisedParam(	151	)	;%	PersonSpecificParametersInSphero.Filets0(8)                        
params(	175	) = 	OptimisedParam(	152	)	;%	PersonSpecificParametersInSphero.Filets0(9)                        
params(	176	) = 	OptimisedParam(	153	)	;%	PersonSpecificParametersInSphero.Filets0(10)                       
params(	177	) = 	OptimisedParam(	154	)	;%	PersonSpecificParametersInSphero.Filets0(11)                       
params(	178	) = 	OptimisedParam(	155	)	;%	PersonSpecificParametersInSphero.Filets0(12)                       
params(	179	) = 	OptimisedParam(	156	)	;%	PersonSpecificParametersInSphero.Filets0(13)                       
params(	180	) = 	OptimisedParam(	157	)	;%	PersonSpecificParametersInSphero.Filets0(14)                       
params(	181	) = 	OptimisedParam(	158	)	;%	PersonSpecificParametersInSphero.Filets0(15)                        
params(	182	) = 	OptimisedParam(	159	)	;%	PersonSpecificParametersInSphero.Filets0(16)                        
params(	183	) = 	OptimisedParam(	160	)	;%	PersonSpecificParametersInSphero.Filets0(17)                        
params(	184	) = 	OptimisedParam(	161	)	;%	PersonSpecificParametersEndoC.Filets0(18)                       
params(	185	) = 	OptimisedParam(	162	)	;%	PersonSpecificParametersEndoC.Filets0(19)                       
params(	186	) = 	OptimisedParam(	163	)	;%	PersonSpecificParametersEndoC.Filets0(20)                       
params(	187	) = 	OptimisedParam(	164	)	;%	PersonSpecificParametersEndoC.Filets0(21)                       
params(	188	) = 	OptimisedParam(	165	)	;%	PersonSpecificParametersEndoC.Filets0(22)                       
params(	189	) = 	OptimisedParam(	166	)	;%	PersonSpecificParametersEndoC.EndoCBasal_Uncertainty            
params(	190	) = 	OptimisedParam(	167	)	;%	PersonSpecificParametersEndoC.EndoCStoredInsulin                
params(	191	) = 	OptimisedParam(	168	)	;%	WashingUncertainty EndoC  
params(	192	) = 	OptimisedParam(	169	)	;%	PersonSpecificParametersInSphero.ExperimentalInducedStress(1)   
params(	193	) = 	OptimisedParam(	170	)	;%	PersonSpecificParametersEndoC.ExperimentalInducedStress(3)   
params(	194	) = 	OptimisedParam(	171	)	;%	PersonSpecificParametersInSphero.InSpheroInsulinPhases_Uncertainty  
params(	195	) = 	OptimisedParam(	172	)	;%	PersonSpecificParametersInSphero.FlowGSISBasalS  
params(	196	) = 	OptimisedParam(	173	)	;%	PersonSpecificParametersEndoC.kv(1)                              
params(	197	) = 	OptimisedParam(	174	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(1)               
params(	198	) = 	OptimisedParam(	175	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(1)             
params(	199	) = 	OptimisedParam(	176	)	;%	PersonSpecificParametersEndoC.Filets0(1)                         
params(	200	) = 	OptimisedParam(	177	)	;%	PersonSpecificParametersEndoC.Fislets50(1)                       
params(	201	) = 	OptimisedParam(	178	)	;%	PersonSpecificParametersEndoC.Filets_hill(1)                     
params(	202	) = 	OptimisedParam(	179	)	;%	PersonSpecificParametersEndoC.kv(2)                              
params(	203	) = 	OptimisedParam(	180	)	;%	PersonSpecificParametersEndoC.ExenatideResponse(2)               
params(	204	) = 	OptimisedParam(	181	)	;%	PersonSpecificParametersEndoC.ExenatideResponse50(2)             
params(	205	) = 	OptimisedParam(	182	)	;%	PersonSpecificParametersEndoC.Filets0(2)                         
params(	206	) = 	OptimisedParam(	183	)	;%	PersonSpecificParametersEndoC.Fislets50(2)                       
params(	207	) = 	OptimisedParam(	184	)	;%	PersonSpecificParametersEndoC.Filets_hill(2)                     
params(	208	) = 	OptimisedParam(	173	)	;%	PersonSpecificParametersInSphero.kv(1)                              
params(	209	) = 	OptimisedParam(	185	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(1)               
params(	210	) = 	OptimisedParam(	186	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(1)             
params(	211	) = 	OptimisedParam(	187	)	;%	PersonSpecificParametersInSphero.Filets0(1)                         
params(	212	) = 	OptimisedParam(	188	)	;%	PersonSpecificParametersInSphero.Fislets50(1)                       
params(	213	) = 	OptimisedParam(	189	)	;%	PersonSpecificParametersInSphero.Filets_hill(1)                     
params(	214	) = 	OptimisedParam(	179	)	;%	PersonSpecificParametersInSphero.kv(2)                              
params(	215	) = 	OptimisedParam(	190	)	;%	PersonSpecificParametersInSphero.ExenatideResponse(2)               
params(	216	) = 	OptimisedParam(	191	)	;%	PersonSpecificParametersInSphero.ExenatideResponse50(2)             
params(	217	) = 	OptimisedParam(	192	)	;%	PersonSpecificParametersInSphero.Filets0(2)                         
params(	218	) = 	OptimisedParam(	193	)	;%	PersonSpecificParametersInSphero.Fislets50(2)                       
params(	219	) = 	OptimisedParam(	194	)	;%	PersonSpecificParametersInSphero.Filets_hill(2)                     

%%
EndoC_params   (1:44) = params(1:44);  % EndoC
InSphero_params(1:44) = params(45:88); % Human MT

%% HepaRG

PersonSpecificParameters.HepaRG_f50(1)    = params(88+1); % Batch 1
PersonSpecificParameters.HepaRG_f50(2)    = params(88+2); % Batch 2
PersonSpecificParameters.HepaRG_f50(3)    = params(88+3); % Batch 3
PersonSpecificParameters.HepaRG_f50(4)    = params(88+4); % Batch 4
PersonSpecificParameters.HepaRG_f50(5)    = params(88+5); % Batch 5

PersonSpecificParameters.HepaRG_f0(1)    = params(88+6); % Batch 1
PersonSpecificParameters.HepaRG_f0(2)    = params(88+7); % Batch 2
PersonSpecificParameters.HepaRG_f0(3)    = params(88+8); % Batch 3
PersonSpecificParameters.HepaRG_f0(4)    = params(88+9); % Batch 4
PersonSpecificParameters.HepaRG_f0(5)    = params(88+10); % Batch 5

PersonSpecificParameters.HepaRG_IS(1)    = params(88+11);  % Batch 1
PersonSpecificParameters.HepaRG_IS(2)    = params(88+12); % Batch 2
PersonSpecificParameters.HepaRG_IS(3)    = params(88+13); % Batch 3
PersonSpecificParameters.HepaRG_IS(4)    = params(88+14); % Batch 4
PersonSpecificParameters.HepaRG_IS(5)    = params(88+15); % Batch 5

% HC
PersonSpecificParameters.InsulinResistanceTimeDependency(1) = params(103+1);
PersonSpecificParameters.IS0(1)                             = params(103+2);
PersonSpecificParameters.Fspheroids0(1)                     = params(103+3); 
PersonSpecificParameters.Fspheroids50(1)                    = params(103+4); 
PersonSpecificParameters.Fspheroids_hill(1)                 = params(103+5);

% NC
PersonSpecificParameters.InsulinResistanceTimeDependency(2) = params(103+5+1);
PersonSpecificParameters.IS0(2)                             = params(103+5+2);
PersonSpecificParameters.Fspheroids0(2)                     = params(103+5+3); 
PersonSpecificParameters.Fspheroids50(2)                    = params(103+5+4); 
PersonSpecificParameters.Fspheroids_hill(2)                 = params(103+5+5);

% FCS
PersonSpecificParameters.InsulinResistanceTimeDependency(3) = params(103+10+1);
PersonSpecificParameters.IS0(3)                             = params(103+10+2);
PersonSpecificParameters.Fspheroids0(3)                     = params(103+10+3); 
PersonSpecificParameters.Fspheroids50(3)                    = params(103+10+4); 
PersonSpecificParameters.Fspheroids_hill(3)                 = params(103+10+5);

% B27
PersonSpecificParameters.InsulinResistanceTimeDependency(4) = params(103+15+1);
PersonSpecificParameters.IS0(4)                             = params(103+15+2);
PersonSpecificParameters.Fspheroids0(4)                     = params(103+15+3); 
PersonSpecificParameters.Fspheroids50(4)                    = params(103+15+4); 
PersonSpecificParameters.Fspheroids_hill(4)                 = params(103+15+5);


%% Both

% FCS
PersonSpecificParameters.kv(3)                              = params(123+1); 
PersonSpecificParameters.ExenatideResponse(3)               = params(123+2); 
PersonSpecificParameters.ExenatideResponse50(3)             = params(123+3); 
PersonSpecificParameters.Filets0(3)                         = params(123+4); 
PersonSpecificParameters.Fislets50(3)                       = params(123+5); 
PersonSpecificParameters.Filets_hill(3)                     = params(123+6); 

% B27
PersonSpecificParameters.kv(4)                              = params(123+6+1); 
PersonSpecificParameters.ExenatideResponse(4)               = params(123+6+2); 
PersonSpecificParameters.ExenatideResponse50(4)             = params(123+6+3); 
PersonSpecificParameters.Filets0(4)                         = params(123+6+4); 
PersonSpecificParameters.Fislets50(4)                       = params(123+6+5); 
PersonSpecificParameters.Filets_hill(4)                     = params(123+6+6); 

% BSA
PersonSpecificParameters.kv(5)                              = 1; 
PersonSpecificParameters.ExenatideResponse(5)               = params(136);
PersonSpecificParameters.ExenatideResponse50(5)             = 1;
PersonSpecificParameters.Filets0(5)                         = 1; 
PersonSpecificParameters.Fislets50(5)                       = params(137); 
PersonSpecificParameters.Filets_hill(5)                     = 1; 

% SM
PersonSpecificParameters.InsulinResistanceTimeDependency(6) = 1;
PersonSpecificParameters.IS0(6)                             = 1;
PersonSpecificParameters.Fspheroids0(6)                     = 1; 
PersonSpecificParameters.Fspheroids50(6)                    = 1; 
PersonSpecificParameters.Fspheroids_hill(6)                 = 1;
PersonSpecificParameters.kv(6)                              = params(137+1); 
PersonSpecificParameters.ExenatideResponse(6)               = params(137+2); 
PersonSpecificParameters.ExenatideResponse50(6)             = params(137+3); 
PersonSpecificParameters.Filets0(6)                         = params(137+4); 
PersonSpecificParameters.Fislets50(6)                       = params(137+5);
PersonSpecificParameters.Filets_hill(6)                     = params(137+6); 

% ULT
PersonSpecificParameters.InsulinResistanceTimeDependency(7) = 1;
PersonSpecificParameters.IS0(7)                             = 1;
PersonSpecificParameters.Fspheroids0(7)                     = 1; 
PersonSpecificParameters.Fspheroids50(7)                    = 1; 
PersonSpecificParameters.Fspheroids_hill(7)                 = 1; 
PersonSpecificParameters.kv(7)                              = params(143+1); 
PersonSpecificParameters.ExenatideResponse(7)               = params(143+2); 
PersonSpecificParameters.ExenatideResponse50(7)             = params(143+3); 
PersonSpecificParameters.Filets0(7)                         = params(143+4); 
PersonSpecificParameters.Fislets50(7)                       = params(143+5);
PersonSpecificParameters.Filets_hill(7)                     = params(143+6); 

%% Exenatide response

% Donor-donor with exenatide
PersonSpecificParameters.ExenatideResponse(8)              = params(149+1);   %Donor 1 Exp6.2
PersonSpecificParameters.ExenatideResponse(9)              = params(149+2);   %Donor 2 ExpS
PersonSpecificParameters.ExenatideResponse(10)             = params(149+3);   %Donor 3 ExpS
PersonSpecificParameters.ExenatideResponse(11)             = params(149+4);   %Donor 4 ExpInSphero 1
PersonSpecificParameters.ExenatideResponse(12)             = params(149+5);   %Donor 5 ExpInSphero 2
PersonSpecificParameters.ExenatideResponse(13)             = params(149+6);   %Donor 6 ExpInSphero 3
PersonSpecificParameters.ExenatideResponse(14)             = params(149+7);   %Donor 7 ExpInSphero 4
% EndoC-BH5 batch-batch
PersonSpecificParameters.ExenatideResponse(15)             = params(149+8);   % Batch 1 7p2 7.3
PersonSpecificParameters.ExenatideResponse(16)             = params(149+9);   % Batch 2 Exp8.1 8p3
PersonSpecificParameters.ExenatideResponse(17)             = params(149+10);  % Batch 3 ref
PersonSpecificParameters.ExenatideResponse(18)             = params(149+11);  % Batch 3 ref
PersonSpecificParameters.ExenatideResponse(19)             = params(149+12);  % Batch 3 ref

%% Exenatide response 50

% Donor-donor with exenatide
PersonSpecificParameters.ExenatideResponse50(8)            = params(161+1);   %Donor 1 Exp6.2
PersonSpecificParameters.ExenatideResponse50(9)            = params(161+2);   %Donor 2 ExpS
PersonSpecificParameters.ExenatideResponse50(10)           = params(161+3);  %Donor 3 ExpS
PersonSpecificParameters.ExenatideResponse50(11)           = params(161+4);  %Donor 4 ExpInSphero 1
PersonSpecificParameters.ExenatideResponse50(12)           = params(161+5);  %Donor 5 ExpInSphero 2
PersonSpecificParameters.ExenatideResponse50(13)           = params(161+6);  %Donor 6 ExpInSphero 3
PersonSpecificParameters.ExenatideResponse50(14)           = params(161+7);  %Donor 7 ExpInSphero 4
% EndoC-BH5 batch-batch
PersonSpecificParameters.ExenatideResponse50(15)           = params(161+8);  % Batch 1 7p2 7.3
PersonSpecificParameters.ExenatideResponse50(16)           = params(161+9);  % Batch 2 Exp8.1 8p3
PersonSpecificParameters.ExenatideResponse50(17)           = params(161+10);  % Batch 3 ref
PersonSpecificParameters.ExenatideResponse50(18)           = params(161+11);  % Batch 2 Exp8.1 8p3
PersonSpecificParameters.ExenatideResponse50(19)           = params(161+12);  % Batch 3 ref

%% Initial functionality

% Donor-donor 
PersonSpecificParameters.Filets0(8)                        = params(173+1);  %Donor 1 Exp6.2
PersonSpecificParameters.Filets0(9)                        = params(173+2);  %Donor 2 ExpS
PersonSpecificParameters.Filets0(10)                       = params(173+3);  %Donor 3 ExpS
PersonSpecificParameters.Filets0(11)                       = params(173+4);  %Donor 4 ExpInSphero 1
PersonSpecificParameters.Filets0(12)                       = params(173+5);  %Donor 5 ExpInSphero 2
PersonSpecificParameters.Filets0(13)                       = params(173+6);  %Donor 6 ExpInSphero 3
PersonSpecificParameters.Filets0(14)                       = params(173+7);  %Donor 7 ExpInSphero 4
PersonSpecificParameters.Filets0(15)                       = params(173+8);  % Batch 1 7.3
PersonSpecificParameters.Filets0(16)                       = params(173+9);  % Batch 2 Exp8.1 8p3
PersonSpecificParameters.Filets0(17)                       = params(173+10); % Batch 3 7p2

% EndoC
PersonSpecificParameters.Filets0(18)                        = params(173+11);      %Donor 8 Exp3.2
PersonSpecificParameters.Filets0(19)                        = params(173+12);      %Donor 9 Exp3.5
PersonSpecificParameters.Filets0(20)                        = params(173+13);      %Donor 10 ExpS
PersonSpecificParameters.Filets0(21)                        = params(173+14);      %Donor 9 Exp3.5
PersonSpecificParameters.Filets0(22)                        = params(173+15);      %Donor 10 ExpS

%% Uncertainties

% Uncertainties
PersonSpecificParameters.EndoCBasal_Uncertainty            = params(188+1);  %measurment uncertainty in ref data
PersonSpecificParameters.EndoCStoredInsulin                = params(188+2);  % all exp
PersonSpecificParameters.EndoCWashing_Uncertainty          = params(188+3);  % EndoCWashing_Uncertainty
PersonSpecificParameters.ExperimentalInducedStress(1)      = params(188+4);   %Exp 6p2
PersonSpecificParameters.ExperimentalInducedStress(3)       = params(188+5);  %Exp 7p3
PersonSpecificParameters.InSpheroInsulinPhases_Uncertainty  = params(188+6);  %SimulateInsulinPhases
PersonSpecificParameters.FlowGSISBasalS                     = params(188+7);  %FlowGSISBasalS

%% Overlaping values HC and NC
PersonSpecificParametersEndoC = PersonSpecificParameters;
% HC
PersonSpecificParametersEndoC.kv(1)                              = params(195+1);
PersonSpecificParametersEndoC.ExenatideResponse(1)               = params(195+2); 
PersonSpecificParametersEndoC.ExenatideResponse50(1)             = params(195+3); 
PersonSpecificParametersEndoC.Filets0(1)                         = params(195+4); 
PersonSpecificParametersEndoC.Fislets50(1)                       = params(195+5); 
PersonSpecificParametersEndoC.Filets_hill(1)                     = params(195+6); 
% NC
PersonSpecificParametersEndoC.kv(2)                              = params(201+1); 
PersonSpecificParametersEndoC.ExenatideResponse(2)               = params(201+2); 
PersonSpecificParametersEndoC.ExenatideResponse50(2)             = params(201+3); 
PersonSpecificParametersEndoC.Filets0(2)                         = params(201+4); 
PersonSpecificParametersEndoC.Fislets50(2)                       = params(201+5); 
PersonSpecificParametersEndoC.Filets_hill(2)                     = params(201+6); 

PersonSpecificParametersInSphero = PersonSpecificParameters;
% HC
PersonSpecificParametersInSphero.kv(1)                              = params(207+1);
PersonSpecificParametersInSphero.ExenatideResponse(1)               = params(207+2); 
PersonSpecificParametersInSphero.ExenatideResponse50(1)             = params(207+3); 
PersonSpecificParametersInSphero.Filets0(1)                         = params(207+4); 
PersonSpecificParametersInSphero.Fislets50(1)                       = params(207+5); 
PersonSpecificParametersInSphero.Filets_hill(1)                     = params(207+6); 
% NC
PersonSpecificParametersInSphero.kv(2)                              = params(207+7); 
PersonSpecificParametersInSphero.ExenatideResponse(2)               = params(207+8); 
PersonSpecificParametersInSphero.ExenatideResponse50(2)             = params(207+9); 
PersonSpecificParametersInSphero.Filets0(2)                         = params(207+10); 
PersonSpecificParametersInSphero.Fislets50(2)                       = params(207+11); 
PersonSpecificParametersInSphero.Filets_hill(2)                     = params(207+12); 

end

