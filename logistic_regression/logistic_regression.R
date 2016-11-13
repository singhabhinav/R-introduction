# We apply the function glm to a formula that describes the transmission type (am) by the horsepower (hp) and weight (wt). This creates a generalized linear model (GLM) in the binomial family.

am.glm = glm(formula=am ~ hp + wt, data=mtcars, family=binomial)

# Wrap parameters

newdata = data.frame(hp=120, wt=2.8)

# Now we apply the function predict to the generalized linear model am.glm along with newdata. We will have to select response prediction type in order to obtain the predicted probability.

predict(am.glm, newdata, type="response")
