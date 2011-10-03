class Collisable a b where
    collide :: a -> b -> String

data SpaceShip = SpaceShip
data GeantSpaceShip = GeantSpaceShip
data Asteroid = Asteroid
data ExplodingAsteroid = ExplodingAsteroid

instance Collisable SpaceShip Asteroid where
    collide _ _ = "collision entre spaceship et asteroid"

instance Collisable SpaceShip ExplodingAsteroid where
    collide _ _ = "collision entre spaceship et explodingasteroid"

instance Collisable GeantSpaceShip Asteroid where
    collide _ _ = "collision entre geantspaceship et asteroid"

instance Collisable GeantSpaceShip ExplodingAsteroid where
    collide _ _ = "collision entre geantspaceship et explodingasteroid"

main = do
    print $ collide GeantSpaceShip Asteroid
    print $ collide GeantSpaceShip ExplodingAsteroid