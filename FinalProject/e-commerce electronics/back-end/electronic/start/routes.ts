/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| This file is dedicated for defining HTTP routes. A single file is enough
| for majority of projects, however you can define routes in different
| files and just make sure to import them inside this file. For example
|
| Define routes in following two files
| ├── start/routes/cart.ts
| ├── start/routes/customer.ts
|
| and then import them inside `start/routes.ts` as follows
|
| import './routes/cart'
| import './routes/customer'
|
*/

import Route from '@ioc:Adonis/Core/Route'

Route.group(() => {

  Route.group(() => {
    
    Route.get('/:brandId/products', 'BrandsController.getByBrandId')
    Route.get("/:brand_name","BrandsController.filterByName");
    Route.get("/:id","BrandsController.getById");
    Route.get("/","BrandsController.getAll");
    Route.post("/","BrandsController.create");
    Route.put("/:id","BrandsController.update");
    Route.delete("/:id","BrandsController.destroy");
  }).prefix("/brands");


  Route.group(() => {
    Route.get("/:id","CartsController.getById");
    Route.get('/', 'CartsController.getWishlists')
    Route.post('/','CartsController.create');
    Route.put("/","CartsController.update");
    Route.delete("/:id","CartsController.destroy");
  }).prefix("/carts");


  Route.group(() => {
    Route.get("/products/:id","CategoriesController.getProductsByCategory");
    Route.post("/","CategoriesController.create");
    Route.put("/","CategoriesController.update");
    Route.get('/','CategoriesController.getAll')
    Route.delete("/:id","CategoriesController.destory");
  }).prefix("/categories");


  Route.group(() => {
    Route.get('/most',"OrderProductsController.mostProduct");
    Route.get("/:id","OrderProductsController.getById");
    Route.get("/","OrderProductsController.getAll");
    Route.post("/","OrderProductsController.create");
    Route.put("/","OrderProductsController.update");
    Route.delete("/:id","OrderProductsController.destory");
  }).prefix("/order_products");

  Route.group(() => {
 
  
    Route.get('/', 'OrdersController.getOrder')
    Route.get('/count','OrdersController.getCountOrder')
    Route.get("/:id","OrdersController.getById");
    Route.post('/', "OrdersController.create");
    Route.put("/","OrdersController.update");
    Route.delete("/:id","OrdersController.destroy");
  }).prefix("/orders");


  
  Route.group(() => {


    Route.get('brands/:brandId/categories/:categoryId/','ProductsController.getByBrandAndCategory')
    Route.get('categories/:categoryId/','ProductsController.getBrandsByCategoryId')
    Route.get("/","ProductsController.getAll");
    Route.get('/color/:productId','ProductsController.getProductByColor');
    Route.get('/size/:productId','ProductsController.getProductSize')
    Route.get("/:id","ProductsController.getById");
    Route.post("/","ProductsController.create");
    Route.put("/","ProductsController.update");
    Route.delete("/:id","ProductsController.destory");
  }).prefix("/products");
  
  Route.group(() => {
    Route.get('/', 'ReviewsController.getReview')
    Route.get("/products","ReviewsController.getTopRatedProducts");
    Route.get('/products/:id/','ReviewsController.getProductReviews')
    Route.get('/count', 'ReviewsController.getCount')
    Route.get("/:id","ReviewesController.getById");
    Route.post('/',"ReviewsController.create");
    Route.put("/","ReviewsController.update");
    Route.delete("/:id","ReviewsController.destroy");
  }).prefix("/reviews");
  Route.get('/search/:searchTerm','SearchesController.search').where('searchTerm', /^[a-zA-Z0-9]+$/)

  Route.group(() => {
   
    Route.get('/', "UsersController.getMe");
    Route.post('/', "UsersController.create");
    Route.put('/', "UsersController.update");
    Route.post('/login',"UsersController.login");
    Route.post('/logout', "UsersController.logout");
    Route.post('/storage',"UsersController.upload");
  }).prefix("/users");

  Route.group(() => {
    
    Route.get("/:id","WishlistsController.getById");
    Route.get('/', 'WishlistsController.getWishlists')
    Route.post('/','WishlistsController.create');
    Route.put("/","WishlistsController.update");
    Route.delete("/:id","WishlistsController.destroy");
  }).prefix("/wishlists");
}).prefix('/api')