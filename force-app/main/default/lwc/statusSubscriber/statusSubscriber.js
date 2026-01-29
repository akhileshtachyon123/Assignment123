import { LightningElement , wire } from 'lwc';
import{subscribe,MessageContext} from 'lightning/messageService';
import DROPDOWN_CHANNEL from '@salesforce/messageChannel/DropdownMessageChannel__c';


export default class StatusSubscriber extends LightningElement 
{
    status='';


    @wire(MessageContext)
    messageContext;

    connectedCallback()
    {
        subscribe(this.messageContext, 
            DROPDOWN_CHANNEL, 
            (message) => {this.status = message.status;});
    }
}