import React from 'react';

const SignInPage =({handleSubmit, history})=>{
    function onSubmit(event){
        event.preventDefault();
        const {currentTarget}=event;
        const formData = new FormData(currentTarget);
        const formValues={
            email: formData.get('email'),
            password: formData.get('password')
        }
        handleSubmit(formValues)
        history.push('/products')
    }
    return(
        <main>
            <h1>Sign In</h1>
            <form onSubmit={onSubmit}>
                <div>
                    <label htmlFor='email'>Email</label>
                    <input id='email' type='email' name='email' />
                </div>
                <div>
                    <label htmlFor='password'>Password</label>
                    <input id='password' type='password' name='password' />
                </div>
                <input type='submit' value='Sign In' />
            </form>
        </main>
    )
}
export default SignInPage;