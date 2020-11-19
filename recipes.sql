-- create a Recipe table 
-- 'id' integer, must have value, is PK of table, auto inc by 1
-- 'name' string max 25
-- 'description' string max 25
-- 'instructions' string max 500
create table Recipe (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name VARCHAR(25), description VARCHAR(50), instructions VARCHAR(500)) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- create an Ingredient table
-- 'id' integer, must have value, is PK of table, auto inc by 1
-- 'name' string max 50
create table Ingredient (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name VARCHAR(50)) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- create a Measure table
-- 'id' integer, must have value, is PK of table, auto inc by 1
-- 'name' string max 30
create table Measure (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, name VARCHAR(30)) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- create a RecipeIngredient table
-- 'recipe_id' integer, must have value
-- 'ingredient_id' integer, must have value
-- 'measure_id' integer
-- 'amount' integer
-- constraint: 'recipe_id' is a foreign key referencing the 'id' column of the Recipe table
-- constraint: 'ingredient_id' is a foreign key referencing the 'id' column of the Ingredient table
-- constraint: 'measure_id' is a foreign key referencing the 'id' column of the Measure table
create table RecipeIngredient (recipe_id INT NOT NULL, ingredient_id INT NOT NULL, measure_id INT, amount INT, 
	CONSTRAINT fk_recipe FOREIGN KEY(recipe_id) REFERENCES Recipe(id), 
	CONSTRAINT fk_ingredient FOREIGN KEY(ingredient_id) REFERENCES Ingredient(id), 
	CONSTRAINT fk_measure FOREIGN KEY(measure_id) REFERENCES Measure(id)) 
	ENGINE=InnoDB DEFAULT CHARSET=utf8; 


INSERT INTO Measure (name) VALUES('CUP'), ('TEASPOON'), ('TABLESPOON'), ('WHOLE');

INSERT INTO Ingredient (name) VALUES('egg'), ('salt'), ('sugar'), ('chocolate'), ('vanilla extract'), ('flour'), ('bacon grease'), ('milk'), ('Cinnamon Toast Crunch');

INSERT INTO Recipe (name, description, instructions) VALUES('Boiled Egg', 'A single boiled egg', 'Add egg to cold water. Bring water to boil. Cook.');

INSERT INTO Recipe (name, description, instructions) VALUES('Chocolate Cake', 'Yummy cake', 'Add eggs, flour, chocolate to pan. Bake at 350 for 1 hour');

INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount) VALUES (1, 1, NULL, 1);

INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount)  VALUES (2, 1, NULL, 3);

INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount)  VALUES (2, 2, 2, 1);

INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount)  VALUES (2, 3, 1, 2);

INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount)  VALUES (2, 4, 1, 1);

-- new recipe Bacon Gravy
INSERT INTO Recipe (name, description, instructions) VALUES ('Bacon Gravy', 'The best gravy for biscuits', 'Whisk flour into grease, add milk and continue stirring until thick, add salt to taste');

-- new RecipeIngredient combinations
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount) VALUES (3, 7, 1, 3);
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount) VALUES (3, 6, 1, 1);
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount) VALUES (3, 8, 1, 2);
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount) VALUES (3, 2, 2, 3);

-- new recipe Cereal
INSERT INTO Recipe (name, description, instructions) VALUES ('Bowl of Cereal', 'Its just cereal', 'Grab bowl. Pour cereal. Pour milk. Grab spoon. Enjoy.');

-- new RecipeIngredient combinations
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount) VALUES (4, 9, 1, 2);
INSERT INTO RecipeIngredient (recipe_id, ingredient_id, measure_id, amount) VALUES (4, 8, 1, 1);

-- new recipe 

-- All recipes query
SELECT * FROM Recipe;

-- query all recipes that use a given ingredient (salt, id 2)
select i.name, r.name
from Recipe as r
join RecipeIngredient as ri on r.id = ri.recipe_id
join Ingredient as i on ri.ingredient_id = i.id
where i.name = 'salt';

-- update bacon gravy recipe to use 3 tablespoons not 3 cups
update RecipeIngredient
set measure_id = 3
where recipe_id = 3 and ingredient_id = 7;

-- get all ingredients and measure amount/unit for a given recipe
select i.name, ri.amount, m.name
from Recipe as r
join RecipeIngredient as ri on r.id = ri.recipe_id
join Ingredient as i on ri.ingredient_id = i.id
join Measure as m on ri.measure_id = m.id
where r.name = 'Bacon Gravy'
order by i.name;