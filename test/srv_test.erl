-module(srv_test).                                         
                                                          
-include_lib("eunit/include/eunit.hrl").                  
                                                          
                                                          
new_test() -> ?assertEqual(srv:go(), stop).                 
                                                          

