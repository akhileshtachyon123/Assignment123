import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import SEARCH_CHANNEL from '@salesforce/messageChannel/SearchMessageChannel__c';


export default class SearchPublisher extends LightningElement {

    @wire(MessageContext)
    messageContext;

    handleSearch(event) {
        publish(this.messageContext, SEARCH_CHANNEL, {
            message: event.target.value
        });
    }
}