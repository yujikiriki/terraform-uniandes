package com.s4n.lambda;

import java.util.Map;
import java.util.List;

import com.amazonaws.regions.Regions;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.DynamodbEvent;
import com.amazonaws.services.lambda.runtime.events.DynamodbEvent.DynamodbStreamRecord;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.model.PutItemRequest;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;

public class HelloLambdaHandler implements RequestHandler<DynamodbEvent, Integer> {

    @Override
    public Integer handleRequest(DynamodbEvent event, Context context) {

        List < DynamodbEvent.DynamodbStreamRecord > records = event.getRecords();
        for (DynamodbEvent.DynamodbStreamRecord record: records) {
            context.getLogger().log("Received event: " + record.getEventName());
            switch (record.getEventName()) {
                case "INSERT":
                    insertDynamoDBItem(record, context);
                break;

                default:
                    break;
            }
        }

        return 0;
    }

    //Insert in to backup table.
    private void insertDynamoDBItem(DynamodbEvent.DynamodbStreamRecord record, Context context) {
        try {
            context.getLogger().log("Creating client");
            AmazonDynamoDB dynamoDBClient = AmazonDynamoDBClientBuilder.standard().withRegion(Regions.US_WEST_2).build();
            context.getLogger().log("Client created");
            context.getLogger().log("Getting Item");
            Map < String, AttributeValue > item = record.getDynamodb().getNewImage();
            context.getLogger().log("Item: " + item);
            context.getLogger().log("Creating request");
            PutItemRequest itemIn = new PutItemRequest( "AmazonPoints" , item);
            context.getLogger().log("Request created " + itemIn);
            dynamoDBClient.putItem(itemIn);
            context.getLogger().log("PUTTED!");
        } catch(Exception ex){
            context.getLogger().log(ex.getMessage());
            ex.printStackTrace();
        }
    }

}
