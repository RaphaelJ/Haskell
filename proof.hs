data Manhattan = Manhattan
data NewYork = NewYork
data USA = USA

-- Hypothèses
-- Les hypothèses se déclarent comme des simples équations
-- Le type défini l'implication de l'hypothèse

-- Etre à New York implique que je sois aux USA
newYorkUSA :: NewYork -> USA
newYorkUSA NewYork = USA

-- Etre à Manhattan New York implique que je sois aux USA
manhatanNewYork :: Manhattan -> NewYork
manhatanNewYork Manhattan = NewYork


-- Preuves
-- Les preuves utilisent uniquement la composition de fonctions
-- Le type défini la thèse, le corps de la fonction la preuve 

-- Si je suis à Manhattan, est-ce que je suis à New York ?
manhattanUSA :: Manhattan -> USA
manhattanUSA = newYorkUSA . manhatanNewYork

-- Si je suis aux USA, est-ce que je suis à Manhattan ?
uSAManhattan :: USA -> Manhattan
uSAManhattan = manhatanNewYork . newYorkUSA


-- Sortie de compilation :

-- uSAManhattan n'est pas une preuve valide
proof.hs:29:16:
    Couldn't match expected type `Manhattan' with actual type `NewYork'


