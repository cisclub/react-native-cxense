package com.reactlibrary;

import com.cxense.cxensesdk.CredentialsProvider;
import com.cxense.cxensesdk.CxenseConfiguration;
import com.cxense.cxensesdk.CxenseSdk;
import com.cxense.cxensesdk.model.CustomParameter;
import com.cxense.cxensesdk.model.PageViewEvent;
import com.facebook.react.bridge.*;
import org.jetbrains.annotations.NotNull;

public class CxenseModule extends ReactContextBaseJavaModule {

    CxenseConfiguration config = CxenseSdk.getInstance().getConfiguration();

    private final ReactApplicationContext reactContext;

    public CxenseModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "Cxense";
    }

    @ReactMethod
    public void initWithUsername(final String username, final String apiKey, final Callback callback) {
        config.setCredentialsProvider(new CredentialsProvider() {
            @Override
            public String getDmpPushPersistentId() {
                return null;
            }

            @Override
            @NotNull
            public String getUsername() {
                return username;
            }

            @Override
            @NotNull
            public String getApiKey() {
                return apiKey;
            }
        });
    }


    @ReactMethod
    public void trackEventWithName(final String eventName, final String siteId, final String location, final String param1, final String value1, final String param2, final String value2, final String param3, final String value3, final Callback callback) {
        try {
            PageViewEvent.Builder builder = new PageViewEvent.Builder(siteId);
            builder.setLocation(location);

            if (param1 != null && value1 != null) {
                builder.addCustomUserParameters(new CustomParameter(param1, value1));
            }

            if (param2 != null && value2 != null) {
                builder.addCustomParameters(new CustomParameter(param2, value2));
            }

            CxenseSdk.getInstance().pushEvents(builder.build());
        } catch (Exception e) {
        }
    }

    @ReactMethod
    public void flushQueue() {
        CxenseSdk.getInstance().flushEventQueue();
    }
}
