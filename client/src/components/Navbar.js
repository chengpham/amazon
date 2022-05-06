import React from 'react';
import { NavLink } from 'react-router-dom';

const Navbar = (props) => {
  function handleSignOut(){
    props.destroySession()
  }
  return(
    <nav>
      <NavLink to='/'> Home </NavLink>
      |
      <NavLink to='/products'> Products Index </NavLink>
      |
      { props.currentUser ? 
      <div>
         <NavLink to='/products/new'> Product New Page </NavLink>
        |
        <span>{props.currentUser.full_name}</span>
        |
        <button onClick={handleSignOut}>Sign Out</button>
      </div>
       : <span> <NavLink to='/sign_in'>Sign In</NavLink> | <NavLink to='/sign_up'>Sign Up</NavLink> </span> }
    </nav>
  )

}

export default Navbar;