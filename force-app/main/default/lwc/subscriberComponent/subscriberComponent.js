import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import MATH_CHANNEL from '@salesforce/messageChannel/mathOperationChannel__c';

export default class SubscriberComponent extends LightningElement {

    currentValue = 0; 
    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    subscribeToMessageChannel() {
        if (this.subscription) {
            return;
        }

        this.subscription = subscribe(
            this.messageContext,
            MATH_CHANNEL,
            (message) => this.handleMessage(message)
        );
    }

    handleMessage(message) {
        const value = Number(message.value);

        switch (message.operation) {
            case 'ADD':
                this.currentValue += value;
                break;

            case 'SUBTRACT':
                this.currentValue -= value;
                break;

            case 'MULTIPLY':
                this.currentValue *= value;
                break;
        }
    }
}