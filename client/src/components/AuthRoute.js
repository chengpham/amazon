import React from 'react';
import {Route, Redirect} from 'react-router-dom'

const AuthRoute = (props) =>{
    const {isAuth, component: Component, ...restProps} = props
    return(
        <Route {...restProps}
        render={
            (routeProps)=>{
                if (isAuth){
                    return <Component {...routeProps}/>

                } else{
                    return <Redirect to='/sign_in' />
                }

            }
            
        }
        />
    )
}
export default AuthRoute;