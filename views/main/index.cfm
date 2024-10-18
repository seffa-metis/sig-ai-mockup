
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sig AI</title>

    <script src="/includes/javascript/SigAI.js"></script>
</head>

<cfoutput>
<div style="margin: 3rem">

    <h1>SIG AIG</h1>
    <form>

        <div class="form-group">
          <label for="offerInfo">Cruise Offer Info</label>
          <textarea id="offerInfo" name="offerInfo" class="form-control" rows="3"></textarea>
        </div>
        <div class="form-group">
          <label for="responseLength">Response Length</label>
          <select id="responseLength" name="responseLength" class="form-control">
            <option>50</option>
            <option>100</option>
            <option>200</option>
            <option>300</option>
            <option>400</option>
            <option>500</option>
          </select>
        </div>
        <div class="form-group">
          <label for="responseFocus">Topic of Focus</label>
          <select id="responseFocus" name="responseFocus" class="form-control">
            <option>Price</option>
            <option>Destinations</option>
            <option>Amenities</option>
          </select>
        </div>
        <div class="form-group">
          <label for="responseTone">Tone</label>
          <select id="responseTone" name="responseTone" class="form-control">
            <option>Funny</option>
            <option>Casual</option>
            <option>Serious</option>
          </select>
        </div>
        <div class="form-group">
            <label for="offerSummary">AI Summary Response</label>
            <textarea readonly id="offerSummary" name="offerSummary" class="form-control" rows="10"></textarea>
        </div>
        <button type="button" id="aiCruiseSummarySubmit" class="btn btn-success">Submit</button>
    </form>

    <form style = "margin-top: 3rem">
        <div class="form-group">
            <label for="finalMessage">CPE Message</label>
            <textarea id="finalMessage" name="finalMessage" class="form-control" rows="10"></textarea>
            <button type="button" id="useAIResponse" class="btn btn-primary">Use AI Response</button>
        </div>
    </form>

    <form style = "margin-top: 3rem">
        <div class="form-group">
            <label for="exampleOffer">Example Offer</label>
            <textarea readonly id="exampleOffer" name="exampleOffer" class="form-control" rows="20">
                {
                    "title": "6 Days Caribbean-Western",
                    "ship": "Celebrity Reflection",
                    "cruiseLine": "Celebrity Cruises",
                    "departingPort": "Fort Lauderdale",
                    "itinerary": [
                    {
                        "day": 1,
                        "port": "Fort Lauderdale",
                        "activity": "EMBARK",
                        "departureTime": "3:30 PM"
                    },
                    {
                        "day": 2,
                        "port": "Cruising",
                        "activity": "CRUISING"
                    },
                    {
                        "day": 3,
                        "port": "George Town, Cayman Islands",
                        "activity": "TENDERED",
                        "arrivalTime": "7:00 AM",
                        "departureTime": "4:00 PM"
                    },
                    {
                        "day": 4,
                        "port": "Cozumel, Mexico",
                        "activity": "DOCKED",
                        "arrivalTime": "10:30 AM",
                        "departureTime": "7:00 PM"
                    },
                    {
                        "day": 5,
                        "port": "Cruising",
                        "activity": "CRUISING"
                    },
                    {
                        "day": 6,
                        "port": "Nassau, Bahamas",
                        "activity": "DOCKED",
                        "arrivalTime": "8:00 AM",
                        "departureTime": "5:00 PM"
                    },
                    {
                        "day": 7,
                        "port": "Fort Lauderdale",
                        "activity": "DEBARK",
                        "arrivalTime": "7:00 AM"
                    }
                    ],
                    "pricing": {
                    "insideCabin": 562,
                    "oceanView": 743,
                    "balcony": 890,
                    "suite": 2424
                    },
                    "specialOffers": [
                        "Up to $1,700 onboard credit",
                        "Up to 75% off the second guest on select ships and sail dates",
                        "Free classic beverage package + basic Wi-Fi",
                        "Back-to-back savings: Save up to $200",
                        "Save up to $50 onboard credit on select departures"
                    ],
                    "sailDates": [
                    {
                        "date": "2025-01-12",
                        "insideCabin": 562,
                        "oceanView": 743,
                        "balcony": 890,
                        "suite": 2424
                    },
                    {
                        "date": "2025-02-09",
                        "insideCabin": 716,
                        "oceanView": "Call Us",
                        "balcony": 1029,
                        "suite": 2505
                    },
                    {
                        "date": "2025-03-09",
                        "insideCabin": 763,
                        "oceanView": 856,
                        "balcony": 939,
                        "suite": 2555
                    }
                    ]
            }
                
            </textarea>
          </div>
    </form>

</div>

</cfoutput>