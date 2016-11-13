# Problem 1

# Fit the model

eruption.lm = lm(eruptions ~ waiting, data=faithful)

# Find out coefficients

coeffs = coefficients(eruption.lm)

# Print coeffs

waiting = 80

# We now fit the eruption duration using the estimated regression equation

duration = coeffs[1] + coeffs[2]*waiting

# Print duration

duration

# Alternative solution using predict()

# wrap the parameter

newdata = data.frame(waiting=80)

predict(eruption.lm, newdata)    # apply predict
