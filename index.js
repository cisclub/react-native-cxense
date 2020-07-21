import { NativeModules } from 'react-native';

const CxenseModule = NativeModules.Cxense;

const Cxense = {
    /*
     * @param username           name of the user under which API will be accessed.
     * @param apiKey             API key. It can be obtained from https://{insight|dmp}.cxense.com
     * @param callbackHandler    (callback) = > {} function called after initialisation is done. if callback equals to NULL/Undefined this means initialisation was successful otherwise it will contain the error.
     */
    init(username, apiKey, callbackHandler) {
        CxenseModule.initWithUsername(username, apiKey, callbackHandler);
    },

    /*
     * @param name              event’s name. It is strongly recommended to provide unique name for the event.
     * @param siteID            the analytics site identifier to be associated with the events.
     * @param location          location of the page. Must be a syntactically valid URL, or else the event will be dropped.
     * @param profileParameter  user profile parameter to the event. Event’s user profile parameters keys are prefixed with “cp_u_” string automatically. You do not need to prefix them manually. Avoid long strings.
     * @param customParameter   custom parameter to the event. Event’s custom parameters keys are prefixed with “cp_” string automatically. You do not need to prefix them manually. Avoid long strings.
     * @param extraParameter    extra property you can add. Avoid long strings.
     * @param callbackHandler   (callback) = > {} function called after initialisation is done. if callback equals to NULL/Undefined this means initialisation was successful otherwise it will contain the error.
     */
    trackEvent(name, siteID, location, profileParameterKey, profileParameterValue, customParameterKey, customParameterValue, extraParameterKey, extraParameterValue, callBackHandler) {
        CxenseModule.trackEventWithName(name, siteID, location, profileParameterKey, profileParameterValue, customParameterKey, customParameterValue, extraParameterKey, extraParameterValue, callBackHandler);
    },

    /*
     * Will force send all events in queue. By default events are sent in batches.
     */
    flushQueue() {
        CxenseModule.flushQueue();
    }
}

export default Cxense;