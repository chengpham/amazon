import React from 'react';
import {User} from '../requests.js'


const SignUpPage=(props)=>{
    const {handleSignUp, history}=props;
    function handleSubmit(event){
        event.preventDefault();
        const {currentTarget}=event;
        const formData=new FormData(currentTarget);
        const signUpParams={
            first_name: formData.get('first_name'),
            last_name: formData.get('last_name'),
            email: formData.get('email'),
            password: formData.get('password'),
            password_confirmation: formData.get('password_confirmation')
        }
        User.create(signUpParams).then(res=>{
            console.log(res.id)
            if (res.id){
                console.log(res.id)
                handleSignUp();
                history.push('/products')
            }
        })

    }
    return(
        <main>
        <h1>Sign Up</h1>
        <form onSubmit={handleSubmit}>
            <div>
                <label htmlFor="first_name">First Name</label>
                <input type='text' name='first_name' id='first_name'/>
            </div>
            <div>
                <label htmlFor="last_name">Last Name</label>
                <input type='text' name='last_name' id='last_name'/>
            </div>
            <div>
                <label htmlFor="email">Email</label>
                <input type='email' name='email' id='email'/>
            </div>
            <div>
                <label htmlFor="password">Password</label>
                <input type='password' name='password' id='password'/>
            </div>
            <div>
                <label htmlFor="password_confirmation">Password Confirmation</label>
                <input type='password' name='password_confirmation' id='password_confirmation'/>
            </div>
            <input type='submit' value='Sign Up'/>
        </form>
        </main>
    )
}
export default SignUpPage;