# README


superadmin   superadmin@x.com password:123456  
admin        admin@x.com password:123456  
user         customer@x.com  password:123456  

Important:  
If you want to create an admin,please mark the admin check out box.  
If you create an admin or super admin,you will be IMMEDIATELY logged into the new account.

************************************************************************************************************************
Operation&Status:
								
                 New Car         Confirm Reservation        Check out           Return									
    Car          'available'     'reserved'                 'checkedout'        'available'									
    Reservation                  'reserved'                 'checkedout'        'returned'									
    Order(Checkout)                                         'checkedout'        'returned'									


*If system cancel the reservation automatically(30 mins delay), the reservation status will be 'Canceled'.

************************************************************************************************************************
Scenarios:

Scenario 1, Delete Car:

You cannot delete a car with unfinished reservations or checkouts(orders) ('reserved' or 'checkedout'), the system will stop this operation and warn you.
You need to finish the reservations and checkouts(orders) first. 

Scenario 2, Delete User:

You cannot delete a user who has reservations or checkouts(orders), the system will stop this operation and warn you.
You need to delete the related reservations and checkouts(orders) first.

Scenario 3, Delete Reservation:

You cannot delete a reservation with checkouts(orders), the system will stop this operation and warn you.
You need to delete the related checkouts(orders) first.

************************************************************************************************************************
Others:

All functions are at the left side of the page. They will change due to your login identity.

An superadmin can rent a car for an user. Just check out the car directly and choose the user ID.




