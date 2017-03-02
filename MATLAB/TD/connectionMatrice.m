function [ matrice_Connexion ] = connectionMatrice(matrice_Generatrice)
    
    [nombre_noeuds_V nombre_noeuds_C] = size(matrice_Generatrice);
    matrice_Connexion = [];
    
    for i = 1:nombre_noeuds_V
        vecteur_Connexion = [];
        for j = 1:nombre_noeuds_C
            if matrice_Generatrice(i,j) == 1
                vecteur_Connexion = [vecteur_Connexion j];
            else
                vecteur_Connexion = [vecteur_Connexion 0];
            end 
        end    
        matrice_Connexion = [matrice_Connexion ; vecteur_Connexion];
    end
end

