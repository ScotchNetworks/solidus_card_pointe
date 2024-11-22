// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/backend/all.js'

window.addEventListener('message', async function(event) {
    const cardPointeContainer = document.getElementById("card-pointe-container");
    if (!cardPointeContainer) {
        return;
    }
    const paymentMethodId = cardPointeContainer.getAttribute('data-payment-method-id');;
    const cardPointeSite = cardPointeContainer.getAttribute('data-card-pointe-site');;
    const orderNumber = cardPointeContainer.getAttribute('data-order-number');
    const orderToken = cardPointeContainer.getAttribute('data-order-token');
    var token;
    try {
        if (event.origin === `https://${cardPointeSite}.cardconnect.com`) {
            token = JSON.parse(event.data);
        } else {
            return;
        };
    } catch (e) {
        return;
    }
    var mytoken = document.getElementById('mytoken');
    mytoken.value = token.message;
    updateOrder(paymentMethodId, mytoken, orderNumber, orderToken);
}, false);

const updateOrder = async (paymentMethodId, token, orderNumber, orderToken) => {
    await fetch(`/api/checkouts/${ orderNumber }`, {
        method: 'PATCH',
        headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Spree.api_key,
        'X-Spree-Order-Token': orderToken
        },
        body: JSON.stringify({
           state: 'payment',
            order: {
              payments_attributes: [{
                payment_method_id: paymentMethodId,
                source_attributes: {
                    card_token: token.value
                }
              }]
            }
        })
    })
    .then(response => response.json())
    .then(() => {
        window.location.href = `/admin/orders/${orderNumber}/payments`
    })
    .catch((error) => {
        console.error('Error:', error);
    });
}