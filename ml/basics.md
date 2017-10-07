# Machine Learning
Notes for a [crash course](https://elitedatascience.com/)

- comprehenisive approach to solving problems.
Algorithms are just one peice, the rest is applying them the right way.

ML - practice of teaching computers how to learn patterns from data for making decisions and predictions.

E.g. learning by trying: red and bright (fire) => pain (it's a pattern)
vs explicit learning: someone warned you that fire is painful

## Key Terminology
- Model - a set of patterns learned from data.
- Algorithm - a specific ML process used to train a model.
- Training data - the dataset from which the algorithm learns the model.
- Test data - a new dataset for reliably evaluating model performance.
- Features - Variables (columns) in the dataset used to train the model.
- Target variable - A specific variable you're trying to predict.
- Observations - Data points (rows) in the dataset.

A `feature` is an individual measurable property or characteristic of a phenomenon being observed

E.g. you want to predict a height based on the weight, gender and age.

Divide the dataset: 120 records for training, 30 records for the test.

## Machine Learning Tasks
Academic machine learning starts with and focuses on individual algorithms.
Applied machine learning, you should first pick the right machine learning task for the job.

A task is a specific objective for your algorithms.
The algorithms can be swapped in and out.
You should always try multiple algorithms to find out which works best.

The two most common categories of tasks are supervised learning and unsupervised learning:

### Supervised Learning (Обучение с учителем)
- tasks for "labeled" data (i.e. you have a target variable).

You must tell the algorithm what's "correct" while training it.
`Regression` is the task for modeling continuous `target variables`.
(Finding out influence of one or several user-defined variables on the target variable.
Влияние одной или нескольких независимых переменных (выбираем сами) на зависимую переменную)

`Classification` is the task for modeling categorical (a.k.a. "class") `target variables`.
The problem of identifying to which of a set of categories a new observation belongs, on the basis of a training set of data containing observations (or instances) whose category membership is known.
Задано множество объектов (ситуаций), разделённых на классы. Требуется построить алгоритм, способный классифицировать  произвольный объект.

### Unsupervised Learning
- tasks for "unlabeled" data (i.e. you do not have a target variable).

Used either as a form of automated data analysis or automated signal extraction.
Unlabeled data has no predetermined "correct answer."
You allow the algorithm to directly learn patterns from the data (without "supervision").

`Clustering` - finding groups within your data.

### The 3 Elements of Great Machine Learning
- human guidance
- relevant data
- avoid overfitting
  An overfit model has "memorized" the noise in the training set, instead of learning the true underlying patterns.
  Choose the right algorythm and tune them correctly.

### 5 core steps:
- Exploratory Analysis ("get to know" the data)
- Data Cleaning
- Feature Engineering (testing, creating features, checking how they work; help your algorithms "focus" on what's important)
- Algorithm Selection
- Model Training

Situational steps:
- Project Scoping (anticipate data needs)
- Data Wrangling (restructure your dataset)
- Preprocessing (transforming your features)
- Ensembling (combining multiple models)

> 'Better data beats fancier algorithms'

## Exploratory Analysis
- gain hints for Data Cleaning
- think of ideas for Feature Engineering
- "feel" the dataset

A quick step!

Basic questions:
- how many observations?
- how many features?
- what are the datatypes of my features?
- do I have a target variable?

### Example observations
the real-estate dataset: a table with columns like beds, baths, year built, roof, exterior_walls, property_type, etc

Make some histograms, look out for:
- Distributions that are unexpected
- Potential outliers that don't make sense
- Features that should be binary (i.e. "wannabe indicator variables")
- Boundaries that don't make sense
- Potential measurement errors

Start making notes about potential fixes you'd like to make, but wait until Data Cleaning to make fixes.

### Distributions of categorical features
Categorical features cannot be visualized through histograms. Instead, you can use bar plots.
A `class` is simply a unique value for a categorical feature. 
E.g. walls can be brick, wood, concrete, etc.

Some of the classes for 'exterior_walls' have very short bars. Those are `sparse` classes.
- In the best case, they don't influence the model much.
- In the worse case, they can cause the model to be overfit.

Make a note to combine or reassign some of these classes 
Wait until Feature Engineering to make changes.

### Segmentations
- powerful ways to observe the relationship between categorical features and numeric features.
Box plots allow you to do so.
(показывает медиану (или, если нужно, среднее), нижний (25-й процентиль) и верхний (75-й процентиль) квартили, минимальное и максимальное значение выборки и выбросы)

Possible insights:
- median transaction price for Single-Family homes is much higher than that for Apartments (one class vs another)
- the min and max transaction prices are comparable between the two classes.
- data truncation may be needed

### Correlations
- allow you to look at the relationships between numeric features and other numeric features
Correlation is a value between -1 and 1 that represents how closely two features move in unison. 
Positive: as one feature increases, the other increases
Negative: as one feature increases, the other decreases.

Correlations near -1 or 1 indicate a strong relationship.
Those closer to 0 indicate a weak relationship.
0 - no relationship

Which features are strongly correlated with the target variable?
Are there interesting or unexpected strong correlations between other features?

## Data Cleaning
Data cleaning can make or break your project.
> Better data beats fancier algorithms.

Different types of data will require different types of cleaning.

### Unwanted observations
Remove unwanted observations from your dataset.
This includes duplicate or irrelevant observations.

#### Duplicate observations
arise when you
- combine datasets from multiple places
- scrape data
- receive data from clients/other departments

#### Irrelevant observations
Remove the observations that don’t actually fit the specific problem that you’re trying to solve.
It's a great time to review your charts from Exploratory Analysis.
Look at the distribution charts for categorical features, remove classes that shouldn't be there.

#### Structural errors
Check for typos or inconsistent capitalization, esp. for categorical features.
Check for mislabeled classes - different, but that should be the same (e.g. N/A and Not Applicable)

#### Unwanted outliers
Outliers are innocent until proven guilty, you should never remove them just because of 'big number'.
Remove them if you have a good reason - e.g. suspicious measurement.

#### Missing data
You cannot simply ignore missing values in your dataset, you must handle them.
The 2 most commonly recommended ways of dealing with missing data actually suck:
- Dropping observations that have missing values
  => suck cause you drop the information, the fact that the data is missing can be informative itself
- Imputing the missing values based on other observations
  =>  leads to a loss in information, "missingness" is almost always informative in itself, and you should tell your algorithm if a value was missing; you're not adding information, but just reinforcing the patterns

*missingness is informative*

What to do?
##### Missing categorical data
- label them as ’Missing’!

##### Missing numeric data
- flag the observation with an indicator variable of missingness.
- fill the original missing value with 0 just to meet the technical requirement of no missing values.

By using this technique of flagging and filling, you are essentially *allowing the algorithm to estimate the optimal constant for missingness*

## Feature Engineering
is about creating new input features from your existing ones.
data cleaning - substraction
feature engineering - addition

You can improve your model performance:
- isolate and highlight key information, which helps your algorithms "focus" on what’s important.
- bring in your own domain expertise
- bring in other people’s domain expertise!

### Domain knowledge
You can often engineer informative features by tapping into your (or others’) expertise about the domain.
You could create an `indicator variable` for transactions during that period.​
Boolean variables (0 or 1), indicate if an observation meets a certain condition, they are useful for isolating key properties.

#### Interaction features
See if you can create any `interaction features` that make sense (combinations of two or more features).
Interaction features can be products, sums, or differences between two features.

Look at each pair of features and ask yourself: "could I combine this information in any way that might be even more useful?"

##### Example
You have features 'num_schools' and 'median_school' (median quality score of these schools)
You might suspect is that what's really important is *having many school options, but only if they are good.*
Then you might create a new feature:
```
feature 'school_score' = 'num_schools' x 'median_school
```

#### Sparse classes
Grouping sparse classes.
That may be hard cause:
- there's no formal rule of how many each class needs
- it depends on the size of your dataset and the number of other features you have
- *rule of thumb* - combine classes until each one has at least ~50 observations (guideline, not a strict rule)

We can group *similar classes*.
Then we can group remaining sparse classes into the class 'Other'.

Often, an eyeball test is enough to decide if you want to group certain classes together.

#### Dummy Variables
Most machine learning algorithms cannot directly handle categorical features (text data)
So we should create dummy variables for our categorical features.
E.g. 8 classes => 8 dummy variables with 0 or 1 values for each record.

#### Remove unused
Remove unused or redundant features from the dataset.
Unused features are those that don’t make sense to pass into our machine learning algorithms.

E.g. ids, features that wouldn't be available at the time of prediction, text descriptions

Redundant - those that have been replaced by other features that you’ve added during feature engineering.

### Conclusion
After completing Data Cleaning and Feature Engineering, you'll have transformed your raw dataset into an *analytical base table (ABT)*.

Not all of the features you engineer need to be winners. In fact, you’ll often find that many of them don’t improve your model, that's ok.

The key is choosing machine learning algorithms that can automatically select the best features among many options.

## Algorithms
### Flaws of linear regression
Their main advantage is that they are easy to interpret and understand.
But they have some disadvantages:
- prone to overfit with many input features
- cannot easily express non-linear relationships

### Regularization
- the first "advanced" tactic for improving model performance.
- a technique used to prevent overfitting by artificially penalizing model coefficients.

- It can discourage large coefficients (by dampening them).
- It can remove features entirely (by setting their coefficients to 0).
- The "strength" of the penalty is tunable.

#### 3 common types of regularized linear regression algorithms:
Overcoming overfitting:
##### Lasso Regression
(Least Absolute Shrinkage and Selection Operator)
Penalizes the *absolute size* of coefficients, leads to cofficients, that can be 0.
Automatic feature selection (autoremove some features)
The "strength" of the penalty should be tuned, stronger penalty => coefficients pushed to 0

##### Ridge Regression
- penalizes the *squared size* of coefficients.
- leads to smaller coefficients, but doesn't force them to zero (feature shrinkage)
- The "strength" of the penalty should be tuned, stronger penalty => coefficients pushed closer to 0

##### Elastic-Net
- penalizes a mix of both absolute and squared size.
- The ratio of the two penalty types should be tuned
- The overall strength should also be tuned.

There is not best type of penalty, it depends on the dataset and problems.

#### Decision trees
Overcoming 'cannot easily express non-linear relationships.'
We need to bring in a new category of algorithms.

Decision trees model data as a "tree" of hierarchical branches. They make branches until they reach "leaves" that represent predictions.

Decision trees can easily model nonlinear relationships.
E.g. reversal of correlation

Unfortunately, individual unconstrained decision trees are very prone to being overfit.​

#### Ensembles
- machine learning methods for combining predictions from multiple separate models.

##### Bagging
- attempts to reduce the chance overfitting complex models.
- trains a large number of "strong" learners in parallel
- A *strong learner* is a model that's relatively unconstrained.
- combines all the strong learners together in order to "smooth out" their predictions.

##### Boosting
- attempts to improve the predictive flexibility of simple models.
- trains a large number of "weak" learners in sequence.
- A *weak learner* is a constrained model (i.e. you could limit the max depth of each decision tree).
- Each one in the sequence focuses on learning from the mistakes of the one before it.
- combines all the weak learners into a single strong learner.

 Bagging uses complex base models and tries to "smooth out" their predictions, while boosting uses simple base models and tries to "boost" their aggregate complexity.

When the base models are `decision trees`, they have special names:
##### Random forests
train a large number of "strong" decision trees and combine their predictions through bagging.

- Each tree is only allowed to choose from a random subset of features to split on (leading to feature selection).
- Each tree is only trained on a random subset of observations (a process called resampling).

- often beat many other models
- swiss-army-knife
- don’t have many complicated parameters to tune

##### Boosted trees
train a sequence of "weak", constrained decision trees and combine their predictions through boosting.

- Each tree is allowed a maximum depth, which should be tuned.
- Each tree in the sequence tries to correct the prediction errors of the one before it.
- beat many other types of models after proper tuning.
- more complicated to tune than random

> The most effective algorithms typically offer a combination of regularization, automatic feature selection, ability to express nonlinear relationships, and/or ensembling. 

Exercise:
https://elitedatascience.com/python-machine-learning-tutorial-scikit-learn
