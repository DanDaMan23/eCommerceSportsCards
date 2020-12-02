import React from 'react'

const Order = props => {

    const {gst, pst, hst, total, subTotal} = props;

    return (
        <div>
            <ul className="list-group">
                <li className="list-group-item">Sub Total: {subTotal}</li>
                <li className="list-group-item">GST: {gst}</li>
                <li className="list-group-item">PST: {pst}</li>
                <li className="list-group-item">HST: {hst}</li>
                <li className="list-group-item">Total: {total}</li>
            </ul>
        </div>
    )
}


export default Order;