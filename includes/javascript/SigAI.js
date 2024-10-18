$(document).ready(function() {
    // Select the button using jQuery by its ID
    const $submitButton = $('#aiCruiseSummarySubmit');
    const $offerSummary = $('#offerSummary');

    // Add the click event listener for the button using jQuery
    $submitButton.on('click', function() {
        // Get values from the input fields
        const cruiseOffer = $('#offerInfo').val();  // From 'offerInfo' textarea
        const length = $('#responseLength').val();  // From 'responseLength' select
        const topic = $('#responseFocus').val();  // From 'responseLength' select
        const tone = $('#responseTone').val();  // From 'responseTone' select

        // Define the data object with the retrieved values
        const postData = {
            prompt: prompt,
            cruiseOffer: cruiseOffer,
            length: length,
            tone: tone,
            topic: topic,
        };

        // Disable the button to prevent multiple clicks
        $submitButton.prop('disabled', true);
        console.log("SUBMITTING");
        // Make the POST request using jQuery's $.ajax
        $.ajax({
            url: 'http://localhost:3000/api/cruiseOfferSummaryAdvanced',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(postData),  // Convert the postData object to JSON
            success: function(response) {
                console.log('Success:', response);  // Log the response data
                $('#offerSummary').val(response.message);
            },
            error: function(error) {
                console.error('Error:', error);  // Handle any errors
            },
            complete: function() {
                // Re-enable the button after the request is complete
                $submitButton.prop('disabled', false);
            }
        });
    });

    // New code for the Use AI Response button
    const $useAIResponseButton = $('#useAIResponse');

    $useAIResponseButton.on('click', function() {
        // Grab the text from the offerSummary textarea
        const aiResponseText = $('#offerSummary').val();

        // Set the text into the finalMessage textarea
        $('#finalMessage').val(aiResponseText);
    });
});
