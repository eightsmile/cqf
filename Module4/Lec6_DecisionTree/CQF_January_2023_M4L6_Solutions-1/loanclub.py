import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.tree import DecisionTreeClassifier, plot_tree, export_graphviz, export_text


train = pd.read_excel('data/lendingclubtraindata.xlsx')
validation=pd.read_excel('data/lendingclubvaldata.xlsx')
test=pd.read_excel('data/lendingclubtestdata.xlsx')


# store target column
y_train = train['loan_status']
y_val=validation['loan_status']
y_test=test['loan_status']

# exercise 1
prob_1=len(y_train[y_train==1])/len(y_train)
prob_2=1.0-prob_1
print("Initial entropy=",-prob_1*np.log2(prob_1)-prob_2*np.log2(prob_2))

# exercise 2
# From the dataset we have that 60.40% own their home and 39.60% rent.
home_owners=train[train.home_ownership==1]
home_owner_prob=len(home_owners)/len(y_train)
print('prob own home=',home_owner_prob)
# Loans were fully paid for 81.72 % of those who owned their home
home_owners_paid=home_owners[home_owners.loan_status==1]
prob_home_owner_paid=len(home_owners_paid)/len(home_owners)
print('prob own home and paid =',prob_home_owner_paid)

# 75.29% of those who rented paid their loans
home_rent=train[train.home_ownership==0]
home_rent_paid=home_rent[home_rent.loan_status==1]
prob_home_rent_paid=len(home_rent_paid)/len(home_rent)
print('prob own rent and paid =',prob_home_rent_paid)

# , the entropy is
# 0.6040(−0.8172 ln(0.8172) − 0.1828 ln(0.1828))
# + 0.3960(−0.7529 ln(0.7529) − 0.2471 ln(0.2471)) = 0.7339
# So the reduction in entropy if we use this feature is 0.7382 − 0.7339 = 0.0043

# exercise 3

# remove target column to create feature only dataset
X_train = train.drop('loan_status',axis=1)
X_val=validation.drop('loan_status',axis=1)
X_test=test.drop('loan_status',axis=1)


clf = DecisionTreeClassifier(criterion='entropy',max_depth=4,min_samples_split=1000,min_samples_leaf=200,random_state=0)
clf = clf.fit(X_train,y_train)
# fig, ax = plt.subplots(figsize=(40, 30))
# plot_tree(clf, filled=True, feature_names=X_train.columns, proportion=True)
# plt.show()

train_score=clf.score(X_train,y_train)
test_score=clf.score(X_test,y_test)

print('train_score=',train_score)
print('test_score=',test_score)
