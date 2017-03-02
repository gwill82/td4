clear all; close all;

% Variables 
% m - mot code 
% G - matrice generatrice 
% H - matrice de controle 
% n - nombre de 1 par ligne/colonne de la matrice g?n?ratrice 
% mc - mot code
% md - mot decod
% matrice_Connexion - matrice qui contabilise les connections entre les
%                     noeud f et c.
% matrice_Reception - matrice repr?santant les transmission des neouds C ?
%                     F (-1 signifie qu'il n'y a pas de connexion)


%% CODAGE DU MOT CODE
m = [0 1 0 1];
G = [ 1 1 0 1 0 0; 
      0 1 1 0 1 0; 
      1 0 0 0 1 1;  
      0 0 1 1 0 1];
G = mod(rref(G),2);
mc = mod(m*G,2);

%% DECOGAGE 
H = gen2par(G);

%on genere une erreur pour le test
mc = [0 1 1 1 1 1];

predicat = mod(H * mc',2);

md = [];
if sum(predicat) == 0
    md = mc(1:4);
else
    matrice_Connexion = connectionMatriceModify(G);
    matrice_Reception = receptionMatrice(matrice_Connexion, mc);
end



 




