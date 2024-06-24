Class-wise (all - alpha and all - beta) PDB IDs were extracted from SCOP2 database and using those IDs, protein structure files were retrieved from PDB server (scop_data_retrieval.ipynb). 
The potential score for each type of residue calculation for all proteins from each class was done using same method as https://pubmed.ncbi.nlm.nih.gov/8907507/ which incorporated dihedral angle values and division of phi-psi plane (potential_calculation.ipynb). 
The potential scores were mapped on each amino acid residues for all the proteins in the dataset which were used as input for time series analysis (potential_mapping.ipynb). 
Finally, time series modelling was done using tseries and forecast R libraries (timeseries.R).
