ellipse a b cx cy rot alpha = 
    let (rot', alpha') = (rad rot, rad alpha)
        deltaAlpha = alpha' - rot'
        deltaCos = cos deltaAlpha
        deltaSin = sin deltaAlpha
        t = sqrt $ 1 / ((deltaCos**2  / a**2) + (deltaSin**2 / b**2))
        (deltaX, deltaY) = (t * deltaCos, t * deltaSin)
        (rotCos, rotSin) = (cos rot', sin rot')
    in (
        deltaX * rotCos - deltaY * rotSin + cx, 
        deltaX * rotSin + deltaY * rotCos + cy 
    )
    
circle cx cy r alpha =
    let alpha' = rad alpha
    in (cos alpha' * r + cx, sin alpha' * r + cy)
    
rad d = d / 360 * 2 * pi