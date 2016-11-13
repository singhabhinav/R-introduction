# Problem 1

# Fit the model

stackloss.lm = lm(stack.loss ~ Air.Flow + Water.Temp + Acid.Conc., data=stackloss)

# Find out coefficients

coeffs = coefficients(stackloss.lm)

# Print coeffs

coeffs

# wrap the parameter

newdata = data.frame(Air.Flow=72, Water.Temp=20, Acid.Conc.=85)

# apply predict

predict(stackloss.lm, newdata)


# Problem 2

# Fit the model

stackloss.lm = lm(stack.loss ~ Air.Flow + Water.Temp + Acid.Conc., data=stackloss)

summary(stackloss.lm)$r.squared
