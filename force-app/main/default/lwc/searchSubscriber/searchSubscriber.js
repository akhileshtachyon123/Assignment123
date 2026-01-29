import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import SEARCH_CHANNEL from '@salesforce/messageChannel/SearchMessageChannel__c';


export default class SearchSubscriber extends LightningElement {

    searchText = '';

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        subscribe(this.messageContext, SEARCH_CHANNEL, (message) => {
            this.searchText = message.message;
        });
    }
}