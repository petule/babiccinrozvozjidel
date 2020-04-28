function AddressLocation(hash, options)
{
	this.hash = hash;
	this.options = (typeof options !== 'undefined' ? options : {});
	this.geocoderObject = null;
	this.lock_timer = null;
	this.lock_term = '';
	this.dirty = false; /* False if user selected address from suggestions */
	this.form = null;
	this.latitude_input = null;
	this.longitude_input = null;
	this.address_input = null;
	this.level_input = null;
	this.callbackOnChange = (typeof this.options['onChange'] !== 'undefined' ? this.options['onChange'] : null);
	this.bindSubmit = (typeof this.options['bindSubmit'] !== 'undefined' ? this.options['bindSubmit'] : true);
}
AddressLocation.prototype = {
	constructor: AddressLocation,
	addressToLocation: function(callback)
	{
		var _this = this;
		var address = this.address_input.val();
		console.log('address: '+address )
		if (address) {
			this.geocode(address, function(latitude, longitude, type) {
				_this.latitude_input.val(latitude);
				_this.longitude_input.val(longitude);
				var level = null;
				console.log('type: '+type)
				if (type == "street_address" || type == "premisex") {
					level = "address";
				} else if (type == "route") {
					level = "street";
				}
				_this.level_input.val(level);
				if (typeof callback === 'function') callback();
			});
		} else {
			this.latitude_input.val(null);
			this.longitude_input.val(null);
			if (typeof callback === 'function') callback();
		}
		return true;
	},
	locationToAddress: function(callback)
	{
		var _this = this;
		var latitude = parseFloat(this.latitude_input.val());
		var longitude = parseFloat(this.longitude_input.val());
		if (latitude && longitude) {
			this.reverseGeocode(latitude, longitude, function(address) {
				_this.address_input.val(address);
				if (typeof callback === 'function') callback();
			});
		} else {
			this.address_input.val(null);
			if (typeof callback === 'function') callback();
		}
		return true;
	},
	
	/* Google Maps */
	geocoder: function()
	{
		if (this.geocoderObject == null) {
			this.geocoderObject = new google.maps.Geocoder();
		}
		return this.geocoderObject
	},
	suggest: function(address, callback) {
		var _this = this;
		var total_results_1 = [];
		var total_results_2 = [];
		
		// Request to Prague area
		_this.geocoder().geocode({
			'address': address,
			'componentRestrictions': {'country': 'CZ', 'administrativeArea': 'Hlavní město Praha' },
		}, function(results_1, status_1) {

			// Collect results
			if (status_1 === google.maps.GeocoderStatus.OK) {
				for (i = 0; i < results_1.length; i++) { 
					if (results_1[i].partial_match != true) {
						total_results_1.push(results_1[i]);
					}
				}
			}

			// Request to Central Bohemian area
			_this.geocoder().geocode({
				'address': address,
				'componentRestrictions': {'country': 'CZ', 'administrativeArea': 'Central Bohemian Region' },
			}, function(results_2, status_2) {

				// Collect results
				if (status_2 === google.maps.GeocoderStatus.OK) {
					for (i = 0; i < results_2.length; i++) { 
						if (results_2[i].partial_match != true) {
							total_results_2.push(results_2[i]);
						}
					}
				}

				// Callback
				if (typeof callback === 'function') callback(total_results_1.concat(total_results_2));
			});

		});
	},
	/*suggest: function(address, callback, restriction) {
		var _this = this;
		var component_restrictions = null;
		
		console.log("SUGGEST START " + address);

		if (restriction == 'prague') {
			component_restrictions = {'country': 'CZ', 'administrativeArea': 'Hlavní město Praha' };
		} else if (restriction == 'central_bohemia') {
			component_restrictions = {'country': 'CZ', 'administrativeArea': 'Central Bohemian Region' };
		} else {
			component_restrictions = {'country': 'CZ' };
		}

		// Request to Prague area
		_this.geocoder().geocode({
			'address': address,
			'componentRestrictions': component_restrictions,
		}, function(results_1, status_1) {

			// Collect results
			var total_results = [];
			if (status_1 === google.maps.GeocoderStatus.OK) {
				for (i = 0; i < results_1.length; i++) { 
					if (results_1[i].partial_match != true) {
						total_results.push(results_1[i]);
					}
				}
			}

			console.log("SUGGEST RESULT " + address);
			console.log(total_results);

			// Callback
			if (typeof callback === 'function') callback(total_results);

		});
	},*/
	geocode: function(address, callback) {
		this.geocoder().geocode({'address': address}, function(results, status) { /* Can't be done with suggest because of bad partial_match behaviour with some addresses */
			if (status === google.maps.GeocoderStatus.OK && results.length > 0) {
				if (typeof callback === 'function') callback(results[0].geometry.location.lat(), results[0].geometry.location.lng(), results[0].types[0]);
			} else {
				console.log('Geocode not successful.');
				if (typeof callback === 'function') callback(null);
			}
		});
	},
	reverseGeocode: function(latitude, longitude, callback) {
		this.geocoder().geocode({'location': {lat: latitude, lng: longitude}}, function(results, status) {
			if (status === google.maps.GeocoderStatus.OK) {
				if (results[0]) {
					if (typeof callback === 'function') callback(results[0].formatted_address);
				} else {
					if (typeof callback === 'function') callback(null);
				}
			} else {
				console.log('Reverse geocode not successful with status: ' + status);
				if (typeof callback === 'function') callback(null);
			}
		});
	},

	/* Events */
	onSuggest: function(term, response, timeout) {
		var _this = this;
		
		// Clear timer if active
		if (this.lock_timer != null) {
			clearTimeout(this.lock_timer);
		}
		
		// Save term
		this.lock_term = term;

		// Activate timer with new settings
		this.lock_timer = setTimeout(function() {
			_this.lock_timer = null;
			_this.suggest(_this.lock_term, function(results) {
				if (results && results.length > 0) {
					suggestions = [];
					for (i = 0; i < results.length; i++) { 
						suggestions.push(results[i].formatted_address);
					}
					response(suggestions);
				}
			});
		}, timeout);
	},
	onSelected: function(address, callback)
	{
		this.address_input.val(address);
		this.addressToLocation(callback);
        if (this.callbackOnChange) this.callbackOnChange(this);
        this.dirty = false;
	},
	onKeypress: function()
	{
		this.latitude_input.val(null);
		this.longitude_input.val(null);
		this.level_input.val(null);
        if (this.callbackOnChange) this.callbackOnChange(this);
        this.dirty = true;
	},
	confirmFullAddress: function(callback)
	{
		var _this = this;
		if (this.dirty && this.address_input.val()) {
			this.suggest(this.address_input.val(), function(results) {
				if (results && results.length > 0) {
					var message = 'Máte na mysli adresu <strong>' + results[0].formatted_address + '</strong>? Pokud ne, klikněte na tlačítko <strong>NE</strong> a adresu upřesněte (doplňte město či číslo popisné).';
					alertify.confirm(message, function (confirmed) {
						if (confirmed) {
							_this.onSelected(results[0].formatted_address, callback);
						} else {
							console.log('Not confirmed');
						}
					});
				} else {
					var message = 'Je nám to velice líto, ale vyplněnou adresu jsme nerozpoznali. Chcete adresu upřesnit? Pokud ano, klikněte na tlačítko <strong>ANO</strong> a doplňte více informací (např. město či číslo popisné). Pokud chcete adresu smazat a formulář odeslat, klikněte na <strong>NE</strong>.';
					alertify.confirm(message, function (confirmed) {
						if (confirmed) {
							console.log('Confirmed');
						} else {
							_this.onSelected(null, callback);
						}
					});
				}
			});
		} else {
			if (typeof callback === 'function') callback();
		}
	},
	validateLevel: function(callback)
	{
	    console.log(this.level_input.val())
		if (this.level_input.val() == "address") {
			if (typeof callback === 'function') callback();
		} else {
			var message = 'Vyplňte prosím přesnou adresu včetně čísla popisného. Vaše přesná poloha ovlivňuje minimální cenu Vaší objednávky.';
			alertify.alert(message);
		}
	},

	/* Ready */
	ready: function()
	{
		var _this = this;
		this.form = $('#address_location_' + this.hash).closest('form');
		this.latitude_input = $('#address_location_' + this.hash + ' input.latitude');
		this.longitude_input = $('#address_location_' + this.hash + ' input.longitude');
		this.address_input = $('#address_location_' + this.hash + ' input.address');
		this.level_input = $('#address_location_' + this.hash + ' input.level');
		alertify.set({ 
			labels: {
				ok: 'Ano',
				cancel: 'Ne'
			}
		});
		this.address_input.typeahead({
			minLength: 3,
			highlight: true,
		}, {
			async: true,
			source: function(query, sync_results, async_results) { 
				_this.onSuggest(query, async_results, 500); 
			}
		});
		this.address_input.bind('typeahead:select', function(ev, suggestion) {
			_this.onSelected(suggestion); 
		});
		this.address_input.keyup(function() { _this.onKeypress(); });
		if (this.bindSubmit === true) {
            this.form.on('submit', function (event) {
                _this.confirmFullAddress(function () {
                    _this.validateLevel(function () {
                        _this.form.off('submit');
                        _this.form.submit();
                    });
                });
                event.preventDefault();
            });
        }
	}
};


function setOrderAddress(id, address, level, latitude, longitude, note) {
    var address_input = $('#'+id);
    var note_input = $('#order_note');
    var address_div = address_input.closest('div');
    var level_input = $('.level', address_div);
    var latitude_input = $('.latitude', address_div);
    var longitude_input = $('.longitude', address_div);
    
    address_input.val(address);
    level_input.val(level);
    latitude_input.val(latitude);
    longitude_input.val(longitude);
    
    note_input.val(note);
}


var address_location_6469ac84a89748bb67b923c833ed0c778a17aea3 = null;
var address_location_0124ec56df62d9a9ba58cb41a2eb8d47031a4acd = null;

$(document).ready(function() {
	if ($('#address_location_6469ac84a89748bb67b923c833ed0c778a17aea3').length > 0) {
		address_location_6469ac84a89748bb67b923c833ed0c778a17aea3 = new AddressLocation('6469ac84a89748bb67b923c833ed0c778a17aea3', {});
		address_location_6469ac84a89748bb67b923c833ed0c778a17aea3.ready();
	}

	if ($('#address_location_0124ec56df62d9a9ba58cb41a2eb8d47031a4acd').length > 0) {
		address_location_0124ec56df62d9a9ba58cb41a2eb8d47031a4acd = new AddressLocation('0124ec56df62d9a9ba58cb41a2eb8d47031a4acd', {});
		address_location_0124ec56df62d9a9ba58cb41a2eb8d47031a4acd.ready();
	}
});

