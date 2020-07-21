# react-native-cxense

## Getting started

`$ npm install react-native-cxense --save`

### Mostly automatic installation

`$ react-native link react-native-cxense`

## Usage
```javascript
import Cxense from 'react-native-cxense';

Cxense.init(
  'user_name',
  'api_key',
  callback => {
    if (callback === undefined) {
      Cxense.trackEvent(
        'event_name',
        'site_id',
        'location_url',
        'param',
        'value',
        'param',
        'value',
        'param',
        'value',
        incallback => {
          if (incallback === undefined) {
            // Cxense.flushQueue();
          } else {
            console.log('Error sending the event: ', incallback);
          }
        },
      );
    } else {
      console.log('Error initializing Cxense:', callback);
    }
  },
);
```
