import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import BUTTON_CHANNEL from '@salesforce/messageChannel/buttonMessageChannel__c';

export default class Subscriber extends LightningElement 
{

    receivedMessage = '';

    @wire(MessageContext)
    messageContext;

    connectedCallback() 
    {
        subscribe(
            this.messageContext,
            BUTTON_CHANNEL,
            (message) => {
                this.receivedMessage = message.message;
            }
        );
    }
}