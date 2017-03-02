function [ matrice_Reception ] = receptionMatrice( matrice_Connexion, mot_Code )
 
    [nombre_noeuds_V nombre_noeuds_C] = size(matrice_Connexion);
    matrice_Reception = [];
    
    for i = 1:nombre_noeuds_V
        vecteur_Reception = [];
        for j = 1:nombre_noeuds_C
            if matrice_Connexion(i,j) == 0
                vecteur_Reception = [vecteur_Reception -1];
            else
                vecteur_Reception = [vecteur_Reception mot_Code(j)];
            end
        end    
        matrice_Reception = [matrice_Reception ; vecteur_Reception];
    end

end

