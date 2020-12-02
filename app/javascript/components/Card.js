import React from 'react'

const Card = props => {
    const {price, quantity, brand, playerId, team} = props;
    return (
        <div>
            <p>Card Component</p>
            <p>Price: ${price}</p>
            <p>Quantity: {quantity}</p>
            <p>Brand: {brand}</p>
        </div>
    )
}


export default Card;